from sqlalchemy.orm import joinedload, subqueryload

from clld.db.meta import DBSession
from clld.db.models import common

from clld.web import datatables
from clld.web.datatables.base import (
    DataTable, Col, LinkCol, LinkToMapCol, RefsCol,
)
from clld.web.datatables.contribution import ContributorsCol
from clld.web.datatables.contributor import NameCol, ContributionsCol
from clld.web.util.helpers import external_link, link
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
            ContributorsCol(self, 'contributors'),
            LinkToMapCol(self, 'm'),
        ]


class LangContributors(DataTable):

    def col_defs(self):
        return [
            NameCol(self, 'name'),
            ContributionsCol(self, 'Languages'),
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
    __constraints__ = [common.Language]

    def base_query(self, _):
        query = DBSession.query(models.CodingSet)\
            .join(common.Language)

        if self.language:
            return query.filter(models.CodingSet.language == self.language)\
                .order_by(models.CodingSet.name)
        else:
            return query.order_by(common.Language.name)

    def col_defs(self):
        # TODO no of coding frames
        # TODO no of verbs
        # TODO no of microroles
        if self.language:
            return [
                LinkCol(self, 'name', sTitle='Coding set'),
            ]
        else:
            return [
                LinkCol(
                    self, 'language', model_col=common.Language.name,
                    get_object=lambda o: o.language),
                LinkCol(self, 'name', sTitle='Coding set'),
            ]


class CodingFrames(DataTable):
    __constraints__ = [common.Language]

    def base_query(self, _):
        query = DBSession.query(models.CodingFrame)\
            .join(common.Language)

        if self.language:
            return query.filter(models.CodingSet.language == self.language)\
                .order_by(models.CodingFrame.name)
        else:
            return query.order_by(common.Language.name)

    def col_defs(self):
        # TODO basic or derived coding frame
        # TODO verb count
        # TODO alternations
        if self.language:
            # TODO list of meanings and values
            return [
                LinkCol(self, 'name', sTitle='Coding frame'),
            ]
        else:
            return [
                LinkCol(
                    self, 'language', model_col=common.Language.name,
                    get_object=lambda o: o.language),
                LinkCol(self, 'name', sTitle='Coding frame'),
            ]


class Forms(DataTable):

    __constraints__ = [common.Language]

    def base_query(self, query):
        query = query.outerjoin(common.ValueSet)\
            .outerjoin(common.Parameter)\
            .outerjoin(models.CodingFrame)
        if self.language:
            query = query.filter(common.ValueSet.language == self.language)
        else:
            query = query.outerjoin(common.ValueSet.language)
        return query.order_by(common.ValueSet.id)

    def col_defs(self):
        columns = []

        if not self.language:
            columns.append(
                LinkCol(
                    self, 'language', model_col=common.Language.name,
                    get_object=lambda o: o.language))

        columns.extend((
            LinkCol(self, 'value', sTitle='Verb form'),
            LinkCol(
                self, 'concept', model_col=common.Parameter.description,
                get_object=lambda o: o.valueset.parameter),
            LinkCol(
                self, 'codingframe',
                sTitle='Basic coding frame',
                model_col=models.CodingFrame.name,
                get_object=lambda o: o.basic_codingframe),
        ))
        return columns


class Alternations(DataTable):
    __constraints__ = [common.Language]

    def base_query(self, _):
        query = DBSession.query(models.Alternation)\
            .join(common.Language)
        if self.language:
            return query.filter(models.Alternation.language == self.language)\
                .order_by(models.Alternation.name)
        else:
            return query.order_by(common.Language.name)

    def col_defs(self):
        if self.language:
            return [
                LinkCol(self, 'name', sTitle='Alternation'),
                Col(self, 'description'),
            ]
        else:
            return [
                LinkCol(
                    self, 'language', model_col=common.Language.name,
                    get_object=lambda o: o.language),
                LinkCol(self, 'name', sTitle='Alternation'),
                Col(self, 'description'),
            ]


def includeme(config):
    """register custom datatables"""

    config.register_datatable('contributors', LangContributors)
    config.register_datatable('languages', Languages)
    config.register_datatable('microroles', Microroles)
    config.register_datatable('codingsets', CodingSets)
    config.register_datatable('codingframes', CodingFrames)
    config.register_datatable('values', Forms)
    config.register_datatable('alternations', Alternations)
