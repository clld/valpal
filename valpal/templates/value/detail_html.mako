<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
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
<p><b>Coding frame</b>: ${h.link(request, ctx.basic_codingframe)}</p>
% if ctx.comment:
<p><b>Comment</b>: ${ctx.comment}</p>
% endif

% if ctx.sentence_assocs:
<h3>${_('Sentences')}</h3>
<table class="example-list">
  % for a in ctx.sentence_assocs:
  <tr>
    <td>(${h.link(request, a.sentence, label=a.sentence.number)})</td>
    <td>
      % if a.description:
      <p>${a.description}</p>
      % endif
      <p>${h.rendered_sentence(a.sentence)}</p>
      % if a.sentence.comment:
      <p><i>Comment</i>: ${a.sentence.comment}</p>
      % endif
      % if a.sentence.references:
      <p>See ${h.linked_references(request, a.sentence)|n}</p>
      % endif
    </td>
  </tr>
  % endfor
</table>
% endif
