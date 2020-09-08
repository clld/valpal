from zope.interface import implementer
from sqlalchemy import (
    Column,
    String,
    Unicode,
    Integer,
    Boolean,
    ForeignKey,
    UniqueConstraint,
)
from sqlalchemy.orm import relationship, backref
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.ext.hybrid import hybrid_property

from clld import interfaces
from clld.db.meta import Base, CustomModelMixin
from clld.db.models import common

from clld_glottologfamily_plugin.models import HasFamilyMixin

from valpal.interfaces import (
    IAlternation,
    ICodingFrame,
    ICodingSet,
    IMicrorole,
)


#-----------------------------------------------------------------------------
# specialized common mapper classes
#-----------------------------------------------------------------------------

@implementer(interfaces.ILanguage)
class Variety(CustomModelMixin, common.Language, HasFamilyMixin):
    pk = Column(Integer, ForeignKey('language.pk'), primary_key=True)
    glottocode = Column(Unicode)

    @property
    def primary_contributors(self):
        return [
            assoc.contributor
            for assoc in sorted(
                self.contributor_assocs,
                key=lambda a: (a.ord, a.contributor.id))]

    @property
    def secondary_contributors(self):
        return ()


class LanguageContributor(Base):
    language_pk = Column(Integer, ForeignKey('language.pk'))
    contributor_pk = Column(Integer, ForeignKey('contributor.pk'))
    language = relationship('Language', backref='contributor_assocs')
    contributor = relationship('Contributor', backref='language_assocs')

    # contributors are ordered.
    ord = Column(Integer, default=1)


@implementer(interfaces.IParameter)
class Concept(CustomModelMixin, common.Parameter):
    pk = Column(Integer, ForeignKey('parameter.pk'), primary_key=True)
    concepticon_id = Column(Unicode)


@implementer(IMicrorole)
class Microrole(Base, common.IdNameDescriptionMixin):
    parameter_pk = Column(Integer, ForeignKey('parameter.pk'))
    parameter = relationship('Parameter', backref='microroles')

    role_letter = Column(Unicode)
    original_or_new = Column(Unicode)


@implementer(ICodingSet)
class CodingSet(Base, common.IdNameDescriptionMixin):
    language_pk = Column(Integer, ForeignKey('language.pk'))
    language = relationship('Language', backref='codingsets')

    comment = Column(Unicode)


@implementer(ICodingFrame)
class CodingFrame(Base, common.IdNameDescriptionMixin):
    language_pk = Column(Integer, ForeignKey('language.pk'))
    language = relationship('Language', backref='codingframes')

    comment = Column(Unicode)
    derived = Column(Unicode)


class CodingFrameIndexNumber(Base):
    codingframe_pk = Column(Integer, ForeignKey('codingframe.pk'))
    codingframe = relationship('CodingFrame', backref='index_numbers')

    codingset_pk = Column(Integer, ForeignKey('codingset.pk'))
    codingset = relationship('CodingSet', backref='index_numbers')

    index_number = Column(Integer)
    argument_type = Column(Unicode)


@implementer(IAlternation)
class Alternation(Base, common.IdNameDescriptionMixin):
    language_pk = Column(Integer, ForeignKey('language.pk'))
    language = relationship('Language', backref='alternations')

    alternation_type = Column(Unicode)
    coding_frames_text = Column(Unicode)
    complexity = Column(Unicode)
