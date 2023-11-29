import html

from sqlalchemy import case, desc
from sqlalchemy.orm import aliased, joinedload, subqueryload

from clld.db.meta import DBSession
from clld.db.models import common

from clld.web import datatables
from clld.web.datatables.base import (
    DataTable, Col, DetailsRowLinkCol, LinkCol, LinkToMapCol, RefsCol,
)
from clld.web.datatables.contribution import ContributorsCol
from clld.web.datatables.contributor import NameCol, ContributionsCol
from clld.web.datatables.sentence import TsvCol, TypeCol
from clld.web.util.helpers import external_link, link, linked_contributors
from clld.web.util.htmllib import HTML

from clld_glottologfamily_plugin.models import Family
from clld_glottologfamily_plugin.datatables import FamilyCol

from valpal import models


class PlainTextCol(Col):
    def format(self, item):
        item = self.get_obj(item)
        return html.escape(super().format(item))


class LinkToSelfCol(Col):
    __kw__ = {'bSearchable': False, 'bSortable': False}

    def format(self, item):
        item = self.get_obj(item)
        return '<span class="link-to-self">{}</span>'.format(
            link(self.dt.req, item, label='Details'))


class GlottocodeCol(Col):
    def format(self, item):
        item = self.get_obj(item)
        return external_link(
            'http://glottolog.org/resource/languoid/id/' + item.glottocode,
            label=item.glottocode,
            title='Language information at Glottolog')


class MapLessFamilyCol(FamilyCol):
    def format(self, item):
        item = self.get_obj(item)
        if item.family:
            label = link(self.dt.req, item.family) if self._link else item.family.name
        else:
            label = 'isolate'
        return label


class ConcepticonCol(Col):
    __kw__ = {'bSearchable': False, 'bSortable': False}

    def format(self, item):
        if item.concepticon_id:
            return external_link(
                'https://concepticon.clld.org/parameters/{}'.format(
                    item.concepticon_id),
                label='{} [{}]'.format(
                    item.concepticon_gloss,
                    item.concepticon_id),
                title='Concept at Concepticon')
        else:
            return ''


class LanguageContributorsCol(Col):

    """Render links to the corresponding Contributors of a Language."""

    __kw__ = {'bSearchable': False, 'bSortable': False}

    def format(self, item):
        contribs = item.contributions
        if contribs:
            # XXX assumes that there is only one contrib per language
            return linked_contributors(self.dt.req, contribs[0])
        else:
            return ''


class Languages(datatables.Languages):
    def base_query(self, query):
        query = super().base_query(query)
        return query\
            .join(models.Variety)\
            .outerjoin(models.Variety.family)

    def col_defs(self):
        # TODO show citation for language contributions
        return [
            LinkCol(self, 'name'),
            GlottocodeCol(self, 'id', sTitle='Glottocode'),
            FamilyCol(self, 'Family', models.Variety),
            Col(self,
                'latitude',
                bSortable=False, bSearchable=False,
                sDescription='<small>The geographic latitude</small>'),
            Col(self,
                'longitude',
                bSortable=False, bSearchable=False,
                sDescription='<small>The geographic longitude</small>'),
            LanguageContributorsCol(self, 'contributor'),
            LinkToMapCol(self, 'm'),
        ]


class Contributions(DataTable):

    def base_query(self, query):
        return query\
            .join(models.Variety)\
            .outerjoin(models.Variety.family)

    def col_defs(self):
        # TODO show citation for language contributions
        return [
            LinkCol(self, 'name'),
            GlottocodeCol(
                self, 'id', sTitle='Glottocode',
                get_object=lambda i: i.language),
            MapLessFamilyCol(
                self, 'family', models.Variety,
                get_object=lambda i: i.language),
            Col(self,
                'latitude',
                get_object=lambda i: i.language,
                bSortable=False, bSearchable=False,
                sDescription='<small>The geographic latitude</small>'),
            Col(self,
                'longitude',
                get_object=lambda i: i.language,
                bSortable=False, bSearchable=False,
                sDescription='<small>The geographic longitude</small>'),
            ContributorsCol(self, 'contributors'),
            #LinkToMapCol(self, 'm'),
        ]


class LangContributors(DataTable):

    def col_defs(self):
        return [
            NameCol(self, 'name'),
            ContributionsCol(self, 'Languages'),
        ]


class Examples(datatables.Sentences):

    __constraints__ = [common.Language, common.Parameter, common.Contribution]

    def base_query(self, query):
        query = super().base_query(query)
        query = query.join(common.Contribution)

        if self.contribution:
            query = query.filter(
                models.Example.language_pk == self.contribution.language_pk)

        return query

    def default_order(self):
        return common.Language.name, models.Example.number

    def col_defs(self):
        number = Col(self, 'number', sTitle='#', model_col=models.Example.number)
        name = LinkCol(self, 'name', sTitle='Primary text', sClass='object-language')
        analyzed = TsvCol(self, 'analyzed', sTitle='Analyzed text')
        gloss = TsvCol(self, 'gloss', sClass="gloss")
        description = Col(
            self, 'description', sTitle=self.req.translate('Translation'),
            sClass="translation")
        comment = PlainTextCol(self, 'comment', bSortable=False)
        details = DetailsRowLinkCol(self, 'd')
        if self.contribution:
            return [
                number, name, analyzed, gloss, description, comment, details]
        else:
            contribution = LinkCol(
                self, 'contribution', sTitle='Language',
                model_col=common.Contribution.name,
                get_object=lambda o: o.contribution)
            return [
                contribution, number, name, analyzed, gloss, description,
                comment, details]


class VerbMeanings(DataTable):

    def col_defs(self):
        name = LinkCol(self, 'name')
        concepticon = ConcepticonCol(self, 'concepticon_id')
        verb_count = Col(
            self, 'verb_count', sTitle='# Verbs',
            model_col=models.VerbMeaning.verb_count,
            bSearchable=False)
        return [name, concepticon, verb_count]


class Microroles(DataTable):

    def base_query(self, query):
        return query.join(models.VerbMeaning)

    def default_order(self):
        return (
            models.VerbMeaning.name,
            desc(models.Microrole.original_or_new),
            models.Microrole.role_letter)

    def col_defs(self):
        role_choices = [
            'A', 'X', 'P', 'S', 'T', 'L', 'I',
            'E', 'M', 'Y', 'R', 'F', 'C', '?'
        ]
        # TODO verb count
        # TODO coding frame count
        return [
            LinkCol(self, 'name'),
            LinkCol(
                self, 'parameter', sTitle='Verb Meaning',
                model_col=common.Parameter.name,
                get_object=lambda o: o.parameter),
            Col(self, 'role_letter', sTitle='Role', choices=role_choices),
            Col(
                self, 'original_or_new', sTitle='Original or New',
                choices=[
                    ('New role', 'New'),
                    ('Original role', 'Original')]),
        ]

    def get_options(self):
        return {'aaSorting': []}


class CodingSets(DataTable):
    __constraints__ = [common.Contribution]

    def base_query(self, query):
        query = query\
            .join(common.Language)\
            .join(models.LanguageContribution)

        if self.contribution:
            query = query.filter(
                models.CodingSet.language_pk == self.contribution.language_pk)

        return query

    def col_defs(self):
        name = LinkCol(self, 'name', sTitle='Coding set', bSearchable=False)
        frame_count = Col(
            self, 'codingframe_count', sTitle='# Coding frames',
            bSearchable=False)
        verb_count = Col(
            self, 'verb_count', sTitle='# Verbs', bSearchable=False)
        role_count = Col(
            self, 'microrole_count', sTitle='# Microroles',
            bSearchable=False)
        comment = PlainTextCol(self, 'comment', bSortable=False)
        if self.contribution:
            return [name, frame_count, verb_count, role_count, comment]
        else:
            contribution = LinkCol(
                self, 'contribution', model_col=common.Contribution.name,
                get_object=lambda o: o.language.contributions[0],
                label='Language')
            return [
                contribution, name, frame_count, verb_count, role_count,
                comment]


class CodingFrames(DataTable):
    __constraints__ = [common.Contribution]

    def base_query(self, query):
        query = query\
            .join(common.Language)\
            .join(models.LanguageContribution)

        if self.contribution:
            query = query.filter(
                models.CodingFrame.language_pk == self.contribution.language_pk)

        return query

    def col_defs(self):
        # TODO verb count
        # TODO alternations
        # TODO list of meanings and values
        name = LinkCol(self, 'name', sTitle='Coding frame')
        type_ = Col(
            self, 'derived', sTitle='Type', choices=['Basic', 'Derived'])
        comment = PlainTextCol(self, 'comment', bSortable=False)
        if self.contribution:
            return [name, type_, comment]
        else:
            contribution = LinkCol(
                self, 'contribution', model_col=common.Contribution.name,
                get_object=lambda o: o.language.contributions[0],
                label='Language')
            return [contribution, name, type_, comment]


class Verbs(DataTable):

    __constraints__ = [common.Contribution, models.CodingFrame, common.Parameter]

    def base_query(self, query):
        query = query.join(common.ValueSet)\
            .join(models.LanguageContribution)\
            .join(models.VerbMeaning)

        if self.parameter:
            query = query.filter(
                common.ValueSet.parameter_pk == self.parameter.pk)
        if self.contribution:
            query = query.filter(
                common.ValueSet.language_pk == self.contribution.language_pk)
        if self.codingframe:
            query = query.filter(
                models.Verb.basic_codingframe_pk == self.codingframe.pk)
        else:
            query = query.join(
                models.CodingFrame,
                models.Verb.basic_codingframe)

        return query

    def default_order(self):
        return common.Parameter.name

    def col_defs(self):
        columns = []

        if not self.codingframe and not self.contribution:
            columns.append(
                LinkCol(
                    self, 'contribution', model_col=common.Contribution.name,
                    get_object=lambda o: o.valueset.language.contributions[0],
                    label='Language'))

        columns.append(LinkCol(self, 'name', sTitle='Verb form'))
        if not self.parameter:
            columns.append(LinkCol(
                self, 'meaning', model_col=common.Parameter.name,
                get_object=lambda o: o.valueset.parameter,
                sTitle='Verb Meaning'))

        # TODO list of microroles
        if not self.codingframe:
            columns.append(
                LinkCol(
                    self, 'codingframe',
                    sTitle='Basic coding frame',
                    model_col=models.CodingFrame.name,
                    get_object=lambda o: o.basic_codingframe))

        columns.append(PlainTextCol(self, 'comment', bSortable=False))

        return columns

    def get_options(self):
        return {'aaSorting': []}


class Alternations(DataTable):
    __constraints__ = [common.Contribution]

    def base_query(self, query):
        query = query\
            .join(common.Language)\
            .join(models.LanguageContribution)

        if self.contribution:
            query = query.filter(
                models.Alternation.language_pk == self.contribution.language_pk)

        return query

    def col_defs(self):
        name = LinkCol(self, 'name', sTitle='Alternation')
        type_ = Col(
            self, 'alternation_type', sTitle='Type',
            choices=['Coded', 'Uncoded'])
        description = PlainTextCol(self, 'description')
        if self.contribution:
            return [name, type_, description]
        else:
            contribution = LinkCol(
                self, 'contribution', model_col=common.Contribution.name,
                get_object=lambda o: o.language.contributions[0],
                label='Language')
            return [contribution, name, type_, description]


class AlternationValues(DataTable):
    __constraints__ = [models.Alternation, models.CodingFrame, models.Verb]

    basic_coding_frame_alias = aliased(models.CodingFrame)
    derived_coding_frame_alias = aliased(models.CodingFrame)

    def base_query(self, query):
        if self.alternation:
            query = query.filter(
                models.AlternationValue.alternation_pk == self.alternation.pk)
        else:
            query = query.join(models.Alternation)

        if self.verb:
            query = query.filter(
                models.AlternationValue.verb_pk == self.verb.pk)
        else:
            query = query.join(models.Verb)
            query = query.join(
                self.basic_coding_frame_alias,
                models.Verb.basic_codingframe)
            query = query.join(common.ValueSet)
            query = query.join(models.VerbMeaning)

        # coding frame means *derived* coding frame here
        if self.codingframe:
            query = query\
                .filter(models.AlternationValue.derived_codingframe_pk == self.codingframe.pk)\
                .filter(models.AlternationValue.alternation_occurs == 'Regularly')
        else:
            # outerjoin, b/c some alterations don't have derived coding frames
            query = query.outerjoin(
                self.derived_coding_frame_alias,
                models.AlternationValue.derived_codingframe)

        return query

    def default_order(self):
        if self.alternation:
            return models.Verb.name
        elif self.verb:
            return case(
                {
                    'Regularly': 0,
                    'Marginally': 1,
                    'Never': 2,
                    'No data': 3,
                },
                value=models.AlternationValue.alternation_occurs,
                else_=4)
        else:
            return models.Alternation.name, models.Verb.name

    def col_defs(self):
        alternation = LinkCol(
            self, 'alternation', model_col=models.Alternation.name,
            get_object=lambda o: o.alternation)
        meaning = LinkCol(
            self, 'meaning', model_col=models.VerbMeaning.name,
            get_object=lambda o: o.verb.valueset.parameter,
            sTitle='Verb Meaning')
        verb = LinkCol(
            self, 'verb_form', model_col=models.Verb.name,
            get_object=lambda o: o.verb)
        basic_frame = LinkCol(
            self, 'basic_coding_frame', model_col=self.basic_coding_frame_alias.name,
            get_object=lambda o: o.verb.basic_codingframe)
        derived_frame = LinkCol(
            self, 'derived_coding_frame', model_col=self.derived_coding_frame_alias.name,
            get_object=lambda o: o.derived_codingframe)
        occurrence = Col(
            self, 'alternation_occurs', sTitle='Occurs',
            choices=['Never', 'Regularly', 'No data', 'Marginally'])
        comment = PlainTextCol(self, 'comment', bSortable=False)
        example_count = Col(
            self, 'example_count',
            sTitle='#&nbsp;Ex.', bSortable=False, bSearchable=False)
        details = LinkToSelfCol(self, 'details', sTitle='')

        cols = []
        if not self.alternation:
            cols.append(alternation)
        if not self.verb:
            cols.append(meaning)
            cols.append(verb)
            cols.append(basic_frame)
        if not self.codingframe:
            cols.append(derived_frame)
            cols.append(occurrence)
        cols.extend((comment, example_count, details))
        return cols

    def get_options(self):
        return {'aaSorting': []}


class VerbCodingFrameMicroroles(DataTable):
    __constraints__ = [models.Microrole]

    def base_query(self, query):
        query = query\
            .join(models.Verb)\
            .join(
                models.CodingFrame,
                models.VerbCodingFrameMicrorole.codingframe)\
            .join(common.ValueSet)\
            .join(models.LanguageContribution)

        if self.microrole:
            query = query.filter(
                models.VerbCodingFrameMicrorole.microrole_pk == self.microrole.pk)
        else:
            query = query.join(models.Microrole)

        return query

    def col_defs(self):
        # | Language | Verb form (<concept>) | Coding frame | Coding set | Argument type |
        # TODO Coding set column
        # TODO Argument type column
        contribution = LinkCol(
            self, 'contribution', sTitle='Language',
            model_col=models.LanguageContribution.name,
            get_object=lambda vcm: vcm.verb.valueset.contribution)
        verb = LinkCol(
            self, 'verb_form',
            model_col=models.Verb.name,
            get_object=lambda vcm: vcm.verb)
        coding_frame = LinkCol(
            self, 'coding_frame',
            model_col=models.CodingFrame.name,
            get_object=lambda vcm: vcm.codingframe)
        return [contribution, verb, coding_frame]


def includeme(config):
    """register custom datatables"""

    config.register_datatable('contributions', Contributions)
    config.register_datatable('contributors', LangContributors)
    config.register_datatable('languages', Languages)
    config.register_datatable('sentences', Examples)
    config.register_datatable('parameters', VerbMeanings)
    config.register_datatable('microroles', Microroles)
    config.register_datatable('codingsets', CodingSets)
    config.register_datatable('codingframes', CodingFrames)
    config.register_datatable('values', Verbs)
    config.register_datatable('alternations', Alternations)
    config.register_datatable('alternationvalues', AlternationValues)
    config.register_datatable('verbcodingframemicroroles', VerbCodingFrameMicroroles)
