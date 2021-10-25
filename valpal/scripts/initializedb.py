import collections
import re

import datetime
from pycldf.sources import Sources
from clldutils.misc import nfilter, slug
from clld.cliutil import Data, bibtex2source
from clld.db.meta import DBSession
from clld.db.models import common
from clld.lib import bibtex

from clld_glottologfamily_plugin.util import load_families

from markdown import markdown
from nameparser import HumanName
from sqlalchemy import distinct, func


import valpal
from valpal import models


def iteritems(cldf, t, *cols):
    cmap = {cldf[t, col].name: col for col in cols}
    for item in cldf[t]:
        for k, v in cmap.items():
            item[v] = item[k]
        yield item


def main(args):

    assert args.cldf, 'The --cldf option is required!'
    assert args.glottolog, 'The --glottolog option is required!'

    data = Data()
    dataset = data.add(
        common.Dataset,
        valpal.__name__,
        id=valpal.__name__,
        domain='valpal.info',
        name='The Valency Patterns Leipzig online database',

        description='Valency Patterns Leipzig',
        published=datetime.date(2013, 1, 1),
        publisher_name="Max Planck Institute for Evolutionary Anthropology",
        publisher_place="Leipzig",
        publisher_url="http://www.eva.mpg.de",
        license="https://creativecommons.org/licenses/by/3.0/",
        jsondata={
            'license_icon': 'cc-by.png',
            'license_name': 'Creative Commons Attribution 3.0 Unported License'},

    )

    for i, (id_, name) in enumerate([
        ('hartmanniren', 'Iren Hartmann'),
        ('haspelmathmartin', 'Martin Haspelmath'),
        ('taylorbradley', 'Bradley Taylor'),
    ]):
        ed = data.add(common.Contributor, id_, id=id_, name=name)
        common.Editor(dataset=dataset, contributor=ed, ord=i + 1)

    etc_dir = args.cldf.directory.parent / 'etc'
    for lang in iteritems(
        args.cldf, 'LanguageTable',
        'id', 'glottocode', 'name',
        'latitude', 'longitude',
        'contributors',
    ):
        comments_file = etc_dir / 'comments-{}.md'.format(lang['glottocode'])
        try:
            with comments_file.open('r', encoding='utf-8') as f:
                desc = f.read().strip()
        except IOError:
            desc = None
        l = data.add(
            models.Variety,
            lang['id'],
            id=lang['id'],
            name=lang['name'],
            description=desc,
            latitude=lang['latitude'],
            longitude=lang['longitude'],
            glottocode=lang['glottocode'],
        )
        DBSession.flush()
        contrib = data.add(
            models.LanguageContribution,
            lang['id'],
            id=lang['id'],
            name=lang['name'],
            language=l,
        )

        for index, name in enumerate(lang['contributors'].split(' and ')):
            parsed_name = HumanName(name)
            pid = slug('{}{}'.format(parsed_name.last, parsed_name.first))
            if pid in data['Contributor']:
                person = data['Contributor'][pid]
            else:
                person = data.add(common.Contributor, pid, id=pid, name=name)
            DBSession.flush()
            DBSession.add(common.ContributionContributor(
                contribution_pk=contrib.pk,
                contributor_pk=person.pk,
                ord=index + 1))

    for rec in bibtex.Database.from_file(args.cldf.bibpath, lowercase=True):
        data.add(common.Source, rec.id, _obj=bibtex2source(rec))

    for param in iteritems(
        args.cldf, 'ParameterTable', 'id', 'concepticonReference', 'name',
        'Concepticon_Gloss'
    ):
        data.add(
            models.Concept,
            param['id'],
            id=param['id'],
            concepticon_id=param['concepticonReference'],
            concepticon_gloss=param['Concepticon_Gloss'],
            name='{} [{}]'.format(param['name'], param['id']),
        )

    load_families(
        Data(),
        [(l.glottocode, l) for l in data['Variety'].values()],
        glottolog_repos=args.glottolog,
        isolates_icon='tcccccc',
        strict=False,
    )

    for row in iteritems(
        args.cldf, 'microroles.csv',
        'id', 'name', 'parameterReference',
        'Role_Letter', 'Original_Or_New'
    ):
        data.add(
            models.Microrole,
            row['id'],
            id=row['id'],
            name=row['name'],
            role_letter=row['Role_Letter'],
            original_or_new=row['Original_Or_New'],
            parameter=data['Concept'][row['Parameter_ID']],
        )

    for row in iteritems(
        args.cldf, 'coding-sets.csv',
        'id', 'languageReference', 'name', 'Comment'
    ):
        data.add(
            models.CodingSet,
            row['id'],
            id=row['id'],
            name=row['name'],
            language=data['Variety'][row['languageReference']],
            comment=row['Comment'],
        )

    for row in iteritems(
        args.cldf, 'coding-frames.csv',
        'id', 'Coding_Frame_Schema', 'description', 'comment', 'Derived',
        'languageReference'
    ):
        data.add(
            models.CodingFrame,
            row['id'],
            id=row['id'],
            name=row['Coding_Frame_Schema'],
            description=row['description'],
            comment=row['comment'],
            derived=row['Derived'],
            language=data['Variety'][row['languageReference']],
        )

    DBSession.flush()

    for row in iteritems(
        args.cldf, 'ExampleTable',
        'id', 'languageReference', 'primaryText', 'analyzedWord', 'gloss',
        'translatedText', 'comment', 'Original_Orthography', 'Translation_Other',
        'Number', 'Example_Type'
    ):
        data.add(
            models.Example,
            row['id'],
            id=row['id'],
            name=row['primaryText'],
            description=row['translatedText'],
            analyzed='\t'.join(row.get('analyzedWord') or ()),
            gloss='\t'.join(row.get('gloss') or ()),
            type=row.get('Example_Type'),
            comment=row.get('comment'),
            original_script=row.get('Original_Orthography'),
            language=data['Variety'][row['languageReference']],
            contribution=data['LanguageContribution'][row['languageReference']],
            number=row.get('Number'),
        )

    refs = collections.defaultdict(list)

    for form in iteritems(
        args.cldf, 'FormTable',
        'id', 'form', 'languageReference', 'parameterReference', 'source',
        'Basic_Coding_Frame_ID', 'original_script', 'simplex_or_complex',
        'comment',
    ):
        vsid = (form['languageReference'], form['parameterReference'])
        vs = data['ValueSet'].get(vsid)
        if not vs:
            vs = data.add(
                common.ValueSet,
                vsid,
                id='-'.join(vsid),
                language=data['Variety'][form['languageReference']],
                parameter=data['Concept'][form['parameterReference']],
                contribution=data['LanguageContribution'][form['languageReference']],
            )
        for ref in form.get('source', []):
            source_id, pages = Sources.parse(ref)
            refs[(vsid, source_id)].append(pages)
        data.add(
            models.Form,
            form['id'],
            id=form['id'],
            name=form['form'],
            basic_codingframe=data['CodingFrame'][form['Basic_Coding_Frame_ID']],
            valueset=vs,
            comment=form['comment'],
            original_script=form['original_script'],
            simplex_or_complex=form['simplex_or_complex'],
        )

    for (vsid, source_id), pages in refs.items():
        DBSession.add(common.ValueSetReference(
            valueset=data['ValueSet'][vsid],
            source=data['Source'][source_id],
            description='; '.join(nfilter(pages))
        ))

    for row in iteritems(
        args.cldf, 'alternations.csv',
        'id', 'name', 'description', 'Alternation_Type', 'Coding_Frames_Text',
        'Complexity', 'languageReference'
    ):
        data.add(
            models.Alternation,
            row['id'],
            id=row['id'],
            name=row['name'],
            description=row['description'],
            alternation_type=row['Alternation_Type'],
            coding_frames_text=row['Coding_Frames_Text'],
            complexity='Complexity',
            language=data['Variety'][row['languageReference']],
        )

    DBSession.flush()

    for row in iteritems(
        args.cldf, 'ExampleTable',
        'id', 'Form_IDs', 'source',
    ):
        example = data['Example'][row['id']]

        for form_id in (row.get('Form_IDs') or ()):
            form = data['Form'][form_id]
            DBSession.add(common.ValueSentence(sentence=example, value=form))

        for ref in row['source']:
            src_id, pages = re.fullmatch(r'(.*?)(\[[^\]]*\])?', ref).groups()
            source = data['Source'][src_id]
            DBSession.add(common.SentenceReference(
                description=pages,
                sentence=example,
                source=source))

    for row in iteritems(
        args.cldf, 'coding-frame-examples.csv',
        'formReference', 'Coding_Frame_ID', 'exampleReference'
    ):
        for example_id in row['exampleReference']:
            DBSession.add(models.CodingFrameExample(
                codingframe=data['CodingFrame'][row['Coding_Frame_ID']],
                value=data['Form'][row['formReference']],
                sentence=data['Example'][example_id]))

    for row in iteritems(
        args.cldf, 'coding-frame-index-numbers.csv',
        'id', 'Coding_Frame_ID', 'Coding_Set_ID', 'Index_Number',
        'Argument_Type'
    ):
        data.add(
            models.CodingFrameIndexNumber,
            row['id'],
            codingframe=data['CodingFrame'][row['Coding_Frame_ID']],
            index_number=int(row['Index_Number']),
            codingset=data['CodingSet'].get(row['Coding_Set_ID']),
            argument_type=row['Argument_Type'],
        )

    for row in iteritems(
        args.cldf, 'form-coding-frame-microroles.csv',
        'id', 'formReference', 'Coding_Frame_ID', 'Microrole_IDs'
    ):
        form = data['Form'][row['formReference']]
        codingframe = data['CodingFrame'][row['Coding_Frame_ID']]
        for role_id in row['Microrole_IDs']:
            DBSession.add(models.FormCodingFrameMicrorole(
                form=form,
                codingframe=codingframe,
                microrole=data['Microrole'][role_id]))

    for row in iteritems(
        args.cldf, 'alternation-values.csv',
        'id', 'Alternation_ID', 'formReference', 'Derived_Code_Frame_ID',
        'Alternation_Occurs', 'comment'
    ):
        alternation = data['Alternation'][row['Alternation_ID']]
        form = data['Form'][row['formReference']]
        if row.get('Derived_Code_Frame_ID'):
            codingframe = data['CodingFrame'][row['Derived_Code_Frame_ID']]
        else:
            codingframe = None

        data.add(
            models.AlternationValue,
            row['id'],
            id=row['id'],
            alternation=alternation,
            form=form,
            derived_codingframe=codingframe,
            alternation_occurs=row['Alternation_Occurs'],
            comment=row['comment']
        )

    DBSession.flush()

    for row in iteritems(
        args.cldf,
        'alternation-values.csv', 'id', 'exampleReference'
    ):
        val = data['AlternationValue'].get(row['id'])
        for ex_id in row.get('exampleReference', ()):
            ex = data['Example'].get(ex_id)
            if val and ex:
                DBSession.add(models.AlternationValueSentence(
                    alternation_value=val,
                    sentence=ex))


def prime_cache(args):
    """If data needs to be denormalized for lookup, do that here.
    This procedure should be separate from the db initialization, because
    it will have to be run periodically whenever data has been updated.
    """

    for language in DBSession.query(common.Language):
        if language.description:
            language.markup_description = markdown(language.description)

    codingframes_per_codingset = dict(
        DBSession.query(
            models.CodingFrameIndexNumber.codingset_pk,
            func.count(distinct(models.CodingFrameIndexNumber.codingframe_pk)))
        .group_by(models.CodingFrameIndexNumber.codingset_pk)
        .all())

    verbs_per_codingset = dict(
        DBSession.query(
            models.CodingFrameIndexNumber.codingset_pk,
            func.count(distinct(models.Form.pk)))
        .where(
            models.CodingFrameIndexNumber.codingframe_pk
            == models.Form.basic_codingframe_pk)
        .group_by(models.CodingFrameIndexNumber.codingset_pk)
        .all())

    microroles_per_codingset = dict(
        DBSession.query(
            models.CodingFrameIndexNumber.codingset_pk,
            func.count(distinct(models.FormCodingFrameMicrorole.microrole_pk)))
        .where(
            models.CodingFrameIndexNumber.codingframe_pk
            == models.FormCodingFrameMicrorole.codingframe_pk)
        .group_by(models.CodingFrameIndexNumber.codingset_pk)
        .all())

    for codingset in DBSession.query(models.CodingSet):
        codingset.codingframe_count = codingframes_per_codingset.get(codingset.pk) or 0
        codingset.verb_count = verbs_per_codingset.get(codingset.pk) or 0
        codingset.microrole_count = microroles_per_codingset.get(codingset.pk) or 0

    verbs_per_concept = dict(
        DBSession.query(
            common.ValueSet.parameter_pk,
            func.count(distinct(common.Value.pk)))
        .where(common.Value.valueset_pk == common.ValueSet.pk)
        .group_by(common.ValueSet.parameter_pk)
        .all())

    for concept in DBSession.query(models.Concept):
        concept.verb_count = verbs_per_concept.get(concept.pk) or 0
