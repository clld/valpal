from sqlalchemy.orm import aliased, joinedload, subqueryload

from clld.db.meta import DBSession
from clld.db.models import common

from clld.web import datatables
from clld.web.datatables.base import (
    DataTable, Col, DetailsRowLinkCol, LinkCol, LinkToMapCol, RefsCol,
)
from clld.web.datatables.contributor import NameCol, ContributionsCol
from clld.web.datatables.sentence import TsvCol, TypeCol
from clld.web.util.helpers import external_link, link, linked_contributors
from clld.web.util.htmllib import HTML

from clld_glottologfamily_plugin.models import Family
from clld_glottologfamily_plugin.datatables import FamilyCol

from valpal import models


class GlottocodeCol(Col):
    def format(self, item):
        return external_link(
            'http://glottolog.org/resource/languoid/id/' + item.id,
            label=item.id,
            title='Language information at Glottolog')


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
        return query\
            .join(Family)\
            .options(joinedload(models.Variety.family))\
            .distinct()

    def col_defs(self):
        # TODO show citation for language contributions
        return [
            LinkCol(self, 'name'),
            GlottocodeCol(self, 'id', sTitle='Glottocode'),
            FamilyCol(self, 'Family', models.Variety),
            Col(self,
                'latitude',
                sDescription='<small>The geographic latitude</small>'),
            Col(self,
                'longitude',
                sDescription='<small>The geographic longitude</small>'),
            LanguageContributorsCol(self, 'contributors'),
            LinkToMapCol(self, 'm'),
        ]


class LangContributors(DataTable):

    def col_defs(self):
        return [
            NameCol(self, 'name'),
            ContributionsCol(self, 'Languages'),
        ]


class Examples(datatables.Sentences):

    __constraints__ = [common.Contribution]

    def base_query(self, query):
        return query\
            .order_by(
                models.Example.contribution_pk,
                models.Example.number)

    def col_defs(self):
        if self.contribution:
            cols = []
        else:
            cols = [
                LinkCol(
                    self, 'contribution', sTitle='Language',
                    model_col=common.Contribution.name,
                    get_object=lambda o: o.contribution),
            ]

        cols.extend((
            Col(self, 'number', sTitle='#', bSortable=False, bSearchable=False),
            LinkCol(self, 'name', sTitle='Primary text', sClass="object-language"),
            TsvCol(self, 'analyzed', sTitle='Analyzed text'),
            TsvCol(self, 'gloss', sClass="gloss"),
            Col(self,
                'description',
                sTitle=self.req.translate('Translation'),
                sClass="translation"),
            TypeCol(self, 'type'),
            DetailsRowLinkCol(self, 'd'),
        ))

        return cols


class Concepts(DataTable):

    def col_defs(self):
        return [
            LinkCol(self, 'name'),
            Col(self, 'verb_count', sTitle='# Verbs'),
        ]


class Microroles(DataTable):

    def base_query(self, _):
        return DBSession.query(models.Microrole)\
            .join(models.Concept)

    def col_defs(self):
        # TODO verb count
        # TODO coding frame count
        return [
            LinkCol(self, 'name'),
            LinkCol(
                self, 'parameter', sTitle='Verb meaning',
                model_col=common.Parameter.name,
                get_object=lambda o: o.parameter),
            Col(self, 'role_letter', sTitle='Role'),
            Col(self, 'original_or_new', sTitle='Original or New'),
        ]


class CodingSets(DataTable):
    __constraints__ = [common.Contribution]

    def base_query(self, _):
        query = DBSession.query(models.CodingSet)\
            .join(common.Language)\
            .join(models.LanguageContribution)

        if self.contribution:
            return query.filter(models.CodingSet.language == self.contribution.language)\
                .order_by(models.CodingSet.name)
        else:
            return query.order_by(common.Contribution.name)

    def col_defs(self):
        if self.contribution:
            return [
                LinkCol(self, 'name', sTitle='Coding set'),
                Col(self, 'codingframe_count', sTitle='# Coding frames'),
                Col(self, 'verb_count', sTitle='# Verbs'),
                Col(self, 'microrole_count', sTitle='# Microroles'),
            ]
        else:
            return [
                LinkCol(
                    self, 'contribution', model_col=common.Contribution.name,
                    get_object=lambda o: o.language.contributions[0],
                    label='Language'),
                LinkCol(self, 'name', sTitle='Coding set'),
                Col(self, 'codingframe_count', sTitle='# Coding frames'),
                Col(self, 'verb_count', sTitle='# Verbs'),
            ]


class CodingFrames(DataTable):
    __constraints__ = [common.Contribution]

    def base_query(self, _):
        query = DBSession.query(models.CodingFrame)\
            .join(common.Language)\
            .join(models.LanguageContribution)\
            .join(common.Contribution)

        if self.contribution:
            return query.filter(models.CodingFrame.language == self.contribution.language)\
                .order_by(models.CodingFrame.name)
        else:
            return query.order_by(common.Contribution.name)

    def col_defs(self):
        if self.contribution:
            cols = []
        else:
            cols = [
                LinkCol(
                    self, 'contribution', model_col=common.Contribution.name,
                    get_object=lambda o: o.language.contributions[0],
                    label='Language'),
            ]

        # TODO verb count
        # TODO alternations
        # TODO list of meanings and values
        cols.extend((
            LinkCol(self, 'name', sTitle='Coding frame'),
            Col(self, 'derived', sTitle='Type', choices=['Basic', 'Derived']),
        ))

        return cols


class Forms(DataTable):

    __constraints__ = [common.Contribution, models.CodingFrame]

    def base_query(self, query):
        query = query.outerjoin(common.ValueSet)\
            .outerjoin(
                models.LanguageContribution,
                models.LanguageContribution.language_pk == common.ValueSet.language_pk)\
            .outerjoin(common.Parameter)\
            .outerjoin(
                models.CodingFrame,
                models.Form.basic_codingframe)

        if self.contribution:
            query = query.filter(common.ValueSet.language_pk == self.contribution.language_pk)
        if self.codingframe:
            query = query.filter(models.Form.basic_codingframe == self.codingframe)

        return query.order_by(common.ValueSet.id)

    def col_defs(self):
        columns = []

        if not self.codingframe and not self.contribution:
            columns.append(
                LinkCol(
                    self, 'contribution', model_col=common.Contribution.name,
                    get_object=lambda o: o.valueset.language.contributions[0],
                    label='Language'))

        columns.extend((
            LinkCol(self, 'value', sTitle='Verb form'),
            LinkCol(
                self, 'concept', model_col=common.Parameter.description,
                get_object=lambda o: o.valueset.parameter),
        ))

        # TODO list of microroles
        if not self.codingframe:
            columns.append(
                LinkCol(
                    self, 'codingframe',
                    sTitle='Basic coding frame',
                    model_col=models.CodingFrame.name,
                    get_object=lambda o: o.basic_codingframe))

        return columns


class Alternations(DataTable):
    __constraints__ = [common.Contribution]

    def base_query(self, _):
        query = DBSession.query(models.Alternation)\
            .join(common.Language)\
            .join(models.LanguageContribution)
        if self.contribution:
            return query.filter(models.Alternation.language == self.contribution.language)\
                .order_by(models.Alternation.name)
        else:
            return query.order_by(common.Contribution.name)

    def col_defs(self):
        if self.contribution:
            cols = []
        else:
            cols = [
                LinkCol(
                    self, 'contribution', model_col=common.Contribution.name,
                    get_object=lambda o: o.language.contributions[0],
                    label='Language'),
            ]

        cols.extend((
            LinkCol(self, 'name', sTitle='Alternation'),
            Col(
                self, 'alternation_type',
                sTitle='Type', choices=['Coded', 'Uncoded']),
            Col(self, 'description'),
        ))

        return cols


class AlternationValues(DataTable):
    __constraints__ = [models.Alternation, models.CodingFrame]

    def base_query(self, _):
        basic_coding_frame_alias = aliased(models.CodingFrame)
        derived_coding_frame_alias = aliased(models.CodingFrame)
        query = DBSession.query(models.AlternationValue)\
            .join(models.Form, isouter=True)\
            .join(common.ValueSet, isouter=True)\
            .join(models.Concept, isouter=True)\
            .join(
                basic_coding_frame_alias,
                models.Form.basic_codingframe,
                isouter=True)\
            .join(
                derived_coding_frame_alias,
                models.AlternationValue.derived_codingframe,
                isouter=True)

        if self.codingframe:
            query = query\
                .filter(
                    models.AlternationValue.derived_codingframe == self.codingframe)\
                .filter(
                    models.AlternationValue.alternation_occurs == 'Regularly')

        if self.alternation:
            return query\
                .filter(models.AlternationValue.alternation == self.alternation)\
                .order_by(models.AlternationValue.id)
        else:
            return query\
                .join(models.Alternation)\
                .order_by(models.Alternation.name)

    def col_defs(self):
        if self.alternation:
            cols = []
        else:
            cols = [LinkCol(
                self, 'alternation', model_col=models.Alternation.name,
                get_object=lambda o: o.alternation)]

        cols.extend((
            LinkCol(
                self, 'concept', model_col=models.Concept.name,
                get_object=lambda o: o.form.valueset.parameter),
            LinkCol(
                self, 'verb_form', model_col=models.Form.name,
                get_object=lambda o: o.form),
            LinkCol(
                self, 'basic_coding_frame', model_col=models.CodingFrame.name,
                get_object=lambda o: o.form.basic_codingframe),
        ))

        if not self.codingframe:
            cols.extend((
                LinkCol(
                    self, 'derived_coding_frame', model_col=models.CodingFrame.name,
                    get_object=lambda o: o.derived_codingframe),
                Col(
                    self, 'alternation_occurs',
                    sTitle='Occurs', choices=['Never', 'Regularly', 'No data', 'Marginally']),
            ))

        return cols


def includeme(config):
    """register custom datatables"""

    config.register_datatable('contributors', LangContributors)
    config.register_datatable('languages', Languages)
    config.register_datatable('sentences', Examples)
    config.register_datatable('parameters', Concepts)
    config.register_datatable('microroles', Microroles)
    config.register_datatable('codingsets', CodingSets)
    config.register_datatable('codingframes', CodingFrames)
    config.register_datatable('values', Forms)
    config.register_datatable('alternations', Alternations)
    config.register_datatable('alternationvalues', AlternationValues)
