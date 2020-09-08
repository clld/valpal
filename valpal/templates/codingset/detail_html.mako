<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "codingframes" %>


<h2>Coding set ‘${ctx.name}’ of ${ctx.language.name}</h2>

<p>Coding frames:<p>

<ul>
  % for cf in sorted({i.codingframe for i in ctx.index_numbers}, key=lambda f: f.name):
  <li>${h.link(request, cf)}</li>
  % endfor
</ul>
