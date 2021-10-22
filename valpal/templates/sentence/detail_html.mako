<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "sentences" %>

<%def name="sidebar()">
    <%util:well>
    <p><b>${_('Contribution')}</b>: ${h.link(request, ctx.language.contributions[0])}</p>
    % if ctx.value_assocs:
        <b>${_('Datapoints')}</b>:
        <ul>
        % for va in ctx.value_assocs:
            % if va.value:
            <li>${h.link(request, va.value, label='%s: %s' % (va.value.valueset.parameter.name, va.value.domainelement.name if va.value.domainelement else va.value.name))}</li>
            % endif
        % endfor
        </ul>
    % endif
    </%util:well>
</%def>

<h2>${ctx.language.name}, ${_('Sentence')} ${ctx.number}</h2>

${h.rendered_sentence(ctx)|n}

<dl>
% if ctx.comment:
<dt>${_('Comment')}:</dt>
<dd>${ctx.markup_comment or ctx.comment|n}</dd>
% endif
% if ctx.type:
<dt>${_('Type')}:</dt>
<dd>${ctx.type}</dd>
% endif
% if ctx.references or ctx.source:
<dt>${_('Source')}:</dt>
% if ctx.source:
<dd>${ctx.source}</dd>
% endif
% if ctx.references:
<dd>${h.linked_references(request, ctx)|n}</dd>
% endif
% endif
</dl>
