from functools import partial

from pyramid.config import Configurator

from clld_glottologfamily_plugin import util

from clld.interfaces import IMapMarker, IValueSet
from clld.web.app import menu_item
from clldutils.svg import icon, data_url

# we must make sure custom models are known at database initialization!
from valpal import models, interfaces


_ = lambda s: s

_('Parameter')
_('Parameters')
_('Contribution')
_('Contributions')
_('Contributor')
_('Contributors')
_('Sentence')
_('Sentences')
_('Value Set')
_('Value')
_('Values')
_('Address')


class LanguageByFamilyMapMarker(util.LanguageByFamilyMapMarker):
    def __call__(self, ctx, req):

        if IValueSet.providedBy(ctx):
            if ctx.language.family:
                return data_url(icon(ctx.language.family.jsondata['icon']))
            return data_url(icon(req.registry.settings.get('clld.isolates_icon', util.ISOLATES_ICON)))

        return super(LanguageByFamilyMapMarker, self).__call__(ctx, req)


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)
    config.include('clld.web.app')

    config.include('clldmpg')

    config.register_menu(
        ('dataset', partial(menu_item, 'dataset', label='Home')),
        ('contributions', partial(menu_item, 'contributions')),
        ('contributors', partial(menu_item, 'contributors')),
        ('parameters', partial(menu_item, 'parameters')),
        ('codingframes', partial(menu_item, 'codingframes', label='All coding frames')),
        ('microroles', partial(menu_item, 'microroles')),
        ('alternations', partial(menu_item, 'alternations', label='All alternations')),
        ('sources', partial(menu_item, 'sources')),
    )

    config.registry.registerUtility(LanguageByFamilyMapMarker(), IMapMarker)

    config.register_resource(
        'microrole', models.Microrole, interfaces.IMicrorole, with_index=True)
    config.register_resource(
        'codingset', models.CodingSet, interfaces.ICodingSet, with_index=True)
    config.register_resource(
        'codingframe', models.CodingFrame, interfaces.ICodingFrame, with_index=True)
    config.register_resource(
        'alternation', models.Alternation, interfaces.IAlternation, with_index=True)
    config.register_resource(
        'alternationvalue', models.AlternationValue, interfaces.IAlternationValue, with_index=True)

    return config.make_wsgi_app()
