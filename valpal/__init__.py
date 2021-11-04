from functools import partial

from pyramid.config import Configurator

from clld_glottologfamily_plugin import util as fam_util

from clld.interfaces import IMapMarker, IValueSet
from clld.db.models import common
from clld.web.app import menu_item
from clldutils.svg import icon, data_url

# we must make sure custom models are known at database initialization!
from valpal import models, interfaces


LANGUAGE_URLS_FROM_OLD_WEBAPP = {
    'ainu': 'ainu1240',
    'balinese': 'bali1278',
    'bezhta': 'bezh1248',
    'bora': 'bora1263',
    'chintang': 'chhi1245',
    'eastern-armenian': 'east2283',
    'emai': 'emai1241',
    'english': 'stan1293',
    'even': 'even1260',
    'evenki': 'even1259',
    'german': 'stan1295',
    'japanese-hokkaido': 'hokk1249',
    'hoocak': 'hoch1243',
    'icelandic': 'icel1247',
    'italian': 'ital1282',
    'jakarta-indonesian': 'indo1316',
    'jaminjung': 'djam1255',
    'japanese-standard': 'nucl1643',
    'ket': 'kett1243',
    'korean': 'kore1280',
    'mandarin': 'mand1415',
    'mandinka': 'mand1436',
    'mapudungun': 'mapu1245',
    'japanese-mitsukaido': 'east2526',
    'arabic': 'stan1318',
    'nen': 'nenn1238',
    'nllng': 'nuuu1241',
    'ojibwe': 'otta1242',
    'russian': 'russ1263',
    'sliammon': 'como1259',
    'sri-lanka-malay': 'sril1245',
    'xaracuu': 'xara1244',
    'yaqui': 'yaqu1251',
    'yoruba': 'yoru1245',
    'yucatec-maya': 'yuca1254',
    'zenzontepec-chatino': 'zenz1235',
}


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
    # move `/languages` out of the way, because the old webapp used that route
    # for contributions
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

    #config.registry.registerUtility(LanguageByFamilyMapMarker(), IMapMarker)

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
    config.register_resource(
        'verbcodingframemicrorole',
        models.VerbCodingFrameMicrorole,
        interfaces.IVerbCodingFrameMicrorole,
        with_index=True)

    config.add_page('project')
    config.add_page('database')
    config.add_page('glossary')
    config.add_page('credits')
    config.add_settings(home_comp=[
        'project', 'database', 'download', 'glossary', 'credits', 'legal',
        'contact',
    ])

    # unbreak links to the old webapp

    config.add_301('/about/project', lambda req: req.route_url('project'))
    config.add_301('/about/database', lambda req: req.route_url('database'))
    config.add_301('/about/credits', lambda req: req.route_url('credits'))
    config.add_301('/about/contact', lambda req: req.route_url('contact'))
    config.add_301('/about/imprint', lambda req: req.route_url('legal'))

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
        lambda req: req.route_url(
            'contributions',
            LANGUAGE_URLS_FROM_OLD_WEBAPP.get(req.matchdict['lid'])
                or req.matchdict['lid']))

    config.add_301(
        '/languages/{lid}/verbs',
        lambda req: req.route_url(
            'contributions', req.matchdict['lid'], _anchor='tverbs'))
    config.add_301(
        '/languages/{lid}/coding_frames',
        lambda req: req.route_url(
            'contributions', req.matchdict['lid'], _anchor='tcodingframes'))
    config.add_301(
        '/languages/{lid}/coding_sets',
        lambda req: req.route_url(
            'contributions', req.matchdict['lid'], _anchor='tcodingsets'))
    config.add_301(
        '/languages/{lid}/alternations',
        lambda req: req.route_url(
            'contributions', req.matchdict['lid'], _anchor='talternations'))
    config.add_301(
        '/languages/{lid}/examples',
        lambda req: req.route_url(
            'contributions', req.matchdict['lid'], _anchor='texamples'))

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
