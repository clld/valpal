<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<% from sqlalchemy.sql.expression import select %>
<% from clld.db.meta import DBSession %>
<% import valpal.models as m %>
<%namespace name="util" file="../util.mako"/>
<%namespace name="vutil" file="../valpal_util.mako"/>
<%! active_menu_item = "contributions" %>


<h2>${ctx.domainelement.name if ctx.domainelement else ctx.name} ${'({})'.format(ctx.original_script) if ctx.original_script else ''}</h2>

<div id="verb-infobox" class="well well-small">
<p><b>${_('Contribution')}</b>: ${h.link(request, ctx.valueset.language.contributions[0])}</p>
% if ctx.valueset.references:
<p><b>References</b>: ${h.linked_references(request, ctx.valueset)|n}</p>
% endif
</div>

% if ctx.simplex_or_complex:
<p>${ctx.simplex_or_complex} verb</p>
% endif
<p><b>${_('Parameter')}</b>: ${h.link(request, ctx.valueset.parameter)}</p>
% if ctx.comment:
<p><b>Comment</b>: ${ctx.comment}</p>
% endif

<h3>Basic coding frame</h3>
<p><b>Schema</b>: ${h.link(request, ctx.basic_codingframe)}</p>

<%
    example_query = DBSession.query(m.Example)\
        .join(m.CodingFrameExample)\
        .filter(
            m.CodingFrameExample.codingframe_pk == ctx.basic_codingframe_pk,
            m.CodingFrameExample.value_pk == ctx.pk)\
        .order_by(m.Example.number)
%>
% if example_query:
<h4>${_('Sentences')}</h4>
${vutil.sentence_list(example_query)}
% endif
