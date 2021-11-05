<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<% from sqlalchemy.sql.expression import or_ %>
<% from clld.db.meta import DBSession %>
<% import valpal.models as m %>
<%namespace name="util" file="../util.mako"/>
<%namespace name="vutil" file="../valpal_util.mako"/>
<%! active_menu_item = "contributions" %>


<h2>${ctx.domainelement.name if ctx.domainelement else ctx.name} ${'({})'.format(ctx.original_script) if ctx.original_script else ''}</h2>

<div id="verb-infobox" class="well well-small">
  <p><b>${_('Contribution')}</b>: ${h.link(request, ctx.valueset.contribution)}</p>
  <p><b>${_('Contributors')}</b>: ${h.linked_contributors(request, ctx.valueset.contribution)}</p>
% if ctx.valueset.references:
<p><b>References</b>: ${h.linked_references(request, ctx.valueset)|n}</p>
% endif
</div>

<%
    examples = list(DBSession.query(m.Example)
        .join(h.models.ValueSentence)
        .join(h.models.Value)
        .join(m.AlternationValueSentence, isouter=True)
        .join(
            m.CodingFrameExample,
            m.CodingFrameExample.sentence_pk == m.Example.pk,
            isouter=True)
        .filter(
            h.models.Value.pk == ctx.pk,
            m.AlternationValueSentence.sentence_pk == None,
            m.CodingFrameExample.sentence_pk == None)
        .order_by(m.Example.number))
%>

% if ctx.simplex_or_complex:
<p>${ctx.simplex_or_complex} verb</p>
% endif
<p><b>${_('Parameter')}</b>: ${h.link(request, ctx.valueset.parameter)}</p>
% if ctx.comment:
<p><b>Comment</b>: ${ctx.comment}</p>
% endif
% if examples:
<p><b>${_('Sentences')}</b>: <a href="#other-examples">see at the bottom</a></p>
% endif


<h3>Basic coding frame</h3>
<p><b>Schema</b>: ${h.link(request, ctx.basic_codingframe)}</p>

<%
    index_numbers = list(DBSession.query(
        m.CodingFrameIndexNumber,
        m.CodingFrameIndexNumberMicrorole)
        .filter(m.CodingFrameIndexNumber.codingframe_pk == ctx.basic_codingframe_pk)
        .join(m.CodingSet, isouter=True)
        .join(m.CodingFrameIndexNumberMicrorole, isouter=True)
        .join(m.Microrole, isouter=True)
        .filter(or_(
            m.CodingFrameIndexNumberMicrorole.pk == None,
            m.Microrole.parameter_pk == ctx.valueset.parameter_pk)))
%>
% if index_numbers:
<table class="table table-bordered" style="width:auto">
<thead>
    <th>#</th>
    <th>Microrole</th>
    <th>Coding set</th>
    <th>Argument type</th>
</thead>
<tbody>
  % for index_number, microrole_assoc in index_numbers:
  <tr>
    <td>${index_number.index_number}</td>
    <td>${h.link(request, microrole_assoc.microrole) if microrole_assoc else ''}</td>
    <td>${h.link(request, index_number.codingset) if index_number.codingset else ''}</td>
    <td>${index_number.argument_type or ''}</td>
  </tr>
  % endfor
</tbody>
</table>
% endif

<%
    basic_cf_examples = list(DBSession.query(m.Example)
        .join(m.CodingFrameExample)
        .filter(
            m.CodingFrameExample.codingframe_pk == ctx.basic_codingframe_pk,
            m.CodingFrameExample.value_pk == ctx.pk)
        .order_by(m.Example.number))
%>
% if basic_cf_examples:
<b>${_('Sentences')} for basic coding frame</b>:
${vutil.sentence_list(basic_cf_examples)}
% endif

<h3>Alternations</h3>
${request.get_datatable('alternationvalues', m.AlternationValue, verb=ctx).render()}

% if examples:
<h3 id="other-examples">${_('Sentences')}</h3>
${vutil.sentence_list(examples)}
% endif
