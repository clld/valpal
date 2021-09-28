<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<% from clld.db.meta import DBSession %>
<% import valpal.models as m %>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "alternations" %>


<h2>Alternation ‘${ctx.name}’
% if ctx.alternation_type:
(${ctx.alternation_type})
% endif
</h2>

% if ctx.description:
<p>${ctx.description | n}</p>
% endif

## TODO value table
## Verb meaning | verb form | occurs (R/M/N) | Basic Coding Frame | Derived Coding Frame |

${request.get_datatable('alternationvalues', m.AlternationValue, alternation=ctx).render()}
