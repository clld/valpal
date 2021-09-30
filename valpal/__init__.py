from functools import partial

from pyramid.config import Configurator

from clld_glottologfamily_plugin import util as fam_util

from clld.interfaces import IMapMarker, IValueSet
from clld.db.models import common
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
_('Datapoints')


class LanguageByFamilyMapMarker(fam_util.LanguageByFamilyMapMarker):
    def __call__(self, ctx, req):

        if IValueSet.providedBy(ctx):
            if ctx.language.family:
                return data_url(icon(ctx.language.family.jsondata['icon']))
            return data_url(icon(req.registry.settings.get('clld.isolates_icon', fam_util.ISOLATES_ICON)))

        return super(LanguageByFamilyMapMarker, self).__call__(ctx, req)


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    settings['route_patterns'] = {
        'languages': '/languoids',
        'language': r'/languoids/{id:[^/\.]+}',
    }
    config = Configurator(settings=settings)
    config.include('clld.web.app')

    config.include('clldmpg')

    config.register_menu(
        ('dataset', partial(menu_item, 'dataset', label='Home')),
        ('contributions', partial(menu_item, 'contributions')),
        ('parameters', partial(menu_item, 'parameters')),
        ('codingframes', partial(menu_item, 'codingframes', label='All coding frames')),
        ('microroles', partial(menu_item, 'microroles')),
        ('alternations', partial(menu_item, 'alternations', label='All alternations')),
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

    config.add_301('/meanings', lambda req: req.route_url('parameters'))
    config.add_301(
        '/meanings/{cid}',
        lambda req: req.route_url('parameters', req.matchdict['cid']))

    config.add_301('/coding_frames', lambda req: req.route_url('codingframes'))
    config.add_301(
        '/coding_frames/{fid}',
        lambda req: req.route_url('codingframes', req.matchdict['fid']))

    config.add_301('/coding_sets', lambda req: req.route_url('codingsets'))
    config.add_301(
        '/coding_sets/{sid}',
        lambda req: req.route_url('codingsets', req.matchdict['sid']))

    config.add_301(
        '/microroles/{mrid}',
        lambda req: req.route_url('microroles', req.matchdict['mrid'].rstrip('.')))

    config.add_301('/languages', lambda req: req.route_url('contributions'))
    config.add_301(
        '/languages/{lid}',
        lambda req: req.route_url('contributions', req.matchdict['lid']))

    config.add_301(
        '/languages/{lid}/coding_frames/{cfid}',
        lambda req: req.route_url('codingframes', req.matchdict['cfid']))

    config.add_301(
        '/languages/{lid}/coding_sets/{csid}',
        lambda req: req.route_url('codingsets', req.matchdict['csid']))

    config.add_301(
        '/languages/{lid}/alternations/{aid}',
        lambda req: req.route_url('alternations', req.matchdict['aid']))

    return config.make_wsgi_app()
