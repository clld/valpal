<%inherit file="../snippet.mako"/>
<%namespace name="util" file="../util.mako"/>

% if request.params.get('parameter'):
    ## called for the info windows on parameter maps
    ##<% valueset = h.DBSession.query(h.models.ValueSet).filter(h.models.ValueSet.parameter_pk == int(request.params['parameter'])).filter(h.models.ValueSet.language_pk == ctx.pk).first() %>
    <% valueset = h.get_valueset(request, ctx) %>
    <h3>${h.link(request, ctx)}</h3>
    % if valueset:
        <b>${_('Value')}</b>:
        <ul>
            % for value in valueset.values:
            <li>
                ${h.link(request, valueset, label=str(value))}
                ${h.format_frequency(request, value)}
            </li>
            % endfor
        </ul>
        % if valueset.references:
            <p>
            <b>${_('Source')}</b>:
            ${h.linked_references(request, valueset)}
            </p>
        % endif
    % endif
% else:
<h3>${h.link(request, ctx)}</h3>
    % if ctx.description:
        <p>${ctx.description}</p>
    % endif
${h.format_coordinates(ctx)}
% endif
