<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "codingsets" %>


<h2>Coding set ‘${ctx.name}’ of ${ctx.language.name}</h2>

% if ctx.comment:
<p><b>Comment</b>: ${ctx.comment}</p>
% endif

<p><b>Coding frames</b>:<p>

<ul>
  % for cf in sorted({i.codingframe for i in ctx.index_numbers}, key=lambda f: f.name):
  <li>${h.link(request, cf)}</li>
  % endfor
</ul>
