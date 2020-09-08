<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "microroles" %>


<h2>${ctx.name}</h2>

<p>Microroles of ${h.link(request, ctx.parameter)}:</p>

<ul>
    % for mr in ctx.parameter.microroles:
    %   if mr == ctx:
    <li><b>${ctx.name}</b></li>
    %   else:
    <li>${h.link(request, mr)}</li>
    %   endif
    % endfor
</ul>

## TODO table
## | Language | Verb form (<concept>) | Coding frame | Coding set | Argument type |
