import collections

import datetime
from pycldf import Sources
from clldutils.misc import nfilter, slug
from clld.cliutil import Data, bibtex2source
from clld.db.meta import DBSession
from clld.db.models import common
from clld.lib import bibtex

from clld_glottologfamily_plugin.util import load_families

from nameparser import HumanName


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

    for lang in iteritems(
        args.cldf, 'LanguageTable',
        'id', 'glottocode', 'name',
        'latitude', 'longitude',
        'contributors',
    ):
        l = data.add(
            models.Variety,
            lang['id'],
            id=lang['id'],
            name=lang['name'],
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

    refs = collections.defaultdict(list)

    for param in iteritems(args.cldf, 'ParameterTable', 'id', 'concepticonReference', 'name'):
        data.add(
            models.Concept,
            param['id'],
            id=param['id'],
            name='{} [{}]'.format(param['name'], param['id']),
        )
    for form in iteritems(args.cldf, 'FormTable', 'id', 'form', 'languageReference', 'parameterReference', 'source'):
        vsid = (form['languageReference'], form['parameterReference'])
        vs = data['ValueSet'].get(vsid)
        if not vs:
            vs = data.add(
                common.ValueSet,
                vsid,
                id='-'.join(vsid),
                language=data['Variety'][form['languageReference']],
                parameter=data['Concept'][form['parameterReference']],
                contribution=contrib,
            )
        for ref in form.get('source', []):
            sid, pages = Sources.parse(ref)
            refs[(vsid, sid)].append(pages)
        data.add(
            common.Value,
            form['id'],
            id=form['id'],
            name=form['form'],
            valueset=vs,
        )

    for (vsid, sid), pages in refs.items():
        DBSession.add(common.ValueSetReference(
            valueset=data['ValueSet'][vsid],
            source=data['Source'][sid],
            description='; '.join(nfilter(pages))
        ))
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


def prime_cache(args):
    """If data needs to be denormalized for lookup, do that here.
    This procedure should be separate from the db initialization, because
    it will have to be run periodically whenever data has been updated.
    """
