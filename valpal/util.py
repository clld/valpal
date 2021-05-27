from clld.db.models.common import Contribution
from clld.interfaces import IRepresentation
from clld.web.adapters import get_adapter


def dataset_detail_html(context=None, request=None, **kw):
    return {
        'example_contribution': Contribution.get('icel1247'),
        'citation': get_adapter(IRepresentation, context, request, ext='md.txt'),
        'bibtex': get_adapter(IRepresentation, context, request, ext='md.bib')}


def contribution_detail_html(context=None, request=None, **kw):
    return {
        'citation': get_adapter(IRepresentation, context, request, ext='md.txt'),
        'bibtex': get_adapter(IRepresentation, context, request, ext='md.bib')}
