<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<% from clld.db.meta import DBSession %>
<% import valpal.models as m %>
<%namespace name="util" file="../util.mako"/>
<%namespace name="vutil" file="../valpal_util.mako"/>
<%! active_menu_item = "alternations" %>

<h2>
Alternation ‘${h.link(request, ctx.alternation)}’
for ${_('Value')} ‘${h.link(request, ctx.verb)}’
</h2>

<table class="altval-codingframe">
  <thead>
    <tr>
      <th>Basic coding frame</th>
      <th></th>
      <th>Derived coding frame</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>${h.link(request, ctx.verb.basic_codingframe)}</td>
      <td><span class="altval-codingframe-arrow">→</span></td>
      <td>${h.link(request, ctx.derived_codingframe) if ctx.derived_codingframe else 'N/A'}</td>
    </tr>
  </tbody>
</table>

% if ctx.alternation_occurs:
<p><b>Alternation occurs</b>: ${ctx.alternation_occurs}</p>
% endif
% if ctx.comment:
<p><b>Comment</b>: ${ctx.comment}</p>
% endif

<%
    basic_examples = list(DBSession.query(m.Example)
        .join(m.CodingFrameExample)
        .filter(
            m.CodingFrameExample.codingframe_pk == ctx.verb.basic_codingframe_pk,
            m.CodingFrameExample.value_pk == ctx.verb_pk)
        .order_by(m.Example.number))
%>
% if basic_examples:
<h3>Examples for basic coding frame</h3>
${vutil.sentence_list(basic_examples)}
% endif

% if ctx.derived_codingframe:
<%
    derived_examples = list(DBSession.query(m.Example)
        .join(m.CodingFrameExample)
        .filter(
            m.CodingFrameExample.codingframe_pk == ctx.derived_codingframe_pk,
            m.CodingFrameExample.value_pk == ctx.verb_pk)
        .order_by(m.Example.number))
%>
%   if derived_examples:
<h3>Examples for derived coding frame</h3>
${vutil.sentence_list(derived_examples)}
%   endif
% endif

<%
    alternation_examples = list(DBSession.query(m.Example)
        .join(m.AlternationValueSentence)
        .filter(m.AlternationValueSentence.alternation_value_pk == ctx.pk)
        .order_by(m.Example.number))
%>
% if alternation_examples:
<h3>Alternation examples</h3>
${vutil.sentence_list(alternation_examples)}
% endif
