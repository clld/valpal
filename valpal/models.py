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


@implementer(interfaces.IContribution)
class LanguageContribution(CustomModelMixin, common.Contribution):
    pk = Column(Integer, ForeignKey('contribution.pk'), primary_key=True)
    language_pk = Column(Integer, ForeignKey('language.pk'))
    language = relationship('Language', backref='contributions')


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

    codingframe_count = Column(Integer)
    verb_count = Column(Integer)
    microrole_count = Column(Integer)

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


class FormCodingFrameMicrorole(Base):
    form_pk = Column(Integer, ForeignKey('form.pk'))
    form = relationship('Form')
    codingframe_pk = Column(Integer, ForeignKey('codingframe.pk'))
    codingframe = relationship('CodingFrame')

    microrole_pk = Column(Integer, ForeignKey('microrole.pk'))
    microrole = relationship('Microrole')


@implementer(interfaces.IValue)
class Form(CustomModelMixin, common.Value):
    pk = Column(Integer, ForeignKey('value.pk'), primary_key=True)

    basic_codingframe_pk = Column(Integer, ForeignKey('codingframe.pk'))
    basic_codingframe = relationship('CodingFrame', backref='forms')


@implementer(IAlternation)
class Alternation(Base, common.IdNameDescriptionMixin):
    language_pk = Column(Integer, ForeignKey('language.pk'))
    language = relationship('Language', backref='alternations')

    alternation_type = Column(Unicode)
    coding_frames_text = Column(Unicode)
    complexity = Column(Unicode)
