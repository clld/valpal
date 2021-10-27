<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<% from sqlalchemy.orm import aliased %>
<% from clld.db.meta import DBSession %>
<% import valpal.models as m %>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "codingframes" %>


% if ctx.derived == 'Derived':
<h2>Derived coding frame</h2>
% else:
<h2>Basic coding frame</h2>
% endif

<p><b>Schema</b>: ${ctx.name}</p>

% if ctx.comment:
<p><b>Comment</b>: ${ctx.comment}</p>
% endif

<%
    index_numbers = list(
        DBSession.query(m.CodingFrameIndexNumber)
        .filter(m.CodingFrameIndexNumber.codingframe_pk == ctx.pk)
        .order_by(m.CodingFrameIndexNumber.index_number))
%>

% if index_numbers:
<table class="table table-bordered" style="width:auto">
<thead>
    <th>#</th>
    <th>Coding set</th>
    <th>Argument type</th>
</thead>
<tbody>
  % for index_number in index_numbers:
  <tr>
    <td>${index_number.index_number}</td>
    % if index_number.codingset:
    <td>${h.link(request, index_number.codingset)}</td>
    % else:
    <td></td>
    % endif
    <td>${index_number.argument_type or ''}</td>
  </tr>
  % endfor
</tbody>
</table>
% endif

% if ctx.derived == 'Derived':
<%
    basic_codingframe_alias = aliased(m.CodingFrame)
    derived_codingframe_alias = aliased(m.CodingFrame)
    alternation_values = list(
        DBSession.query(m.AlternationValue)
        .join(m.AlternationValue.alternation, isouter=True)
        .join(
            derived_codingframe_alias,
            m.AlternationValue.derived_codingframe,
            isouter=True)
        .join(m.AlternationValue.verb, isouter=True)
        .join(basic_codingframe_alias, m.Verb.basic_codingframe, isouter=True)
        .filter(m.AlternationValue.derived_codingframe == ctx)
        .order_by(m.Alternation.pk)
        .distinct(m.Alternation.pk))
%>

%   if alternation_values:
<h3>Derived from</h3>

<table class="table table-bordered" style="width:auto">
<tr><th>Basic coding frame</th><th>via</th></tr>
%     for val in alternation_values:
  <tr>
    <td>${h.link(request, val.verb.basic_codingframe)}</td>
    <td>${h.link(request, val.alternation)}</td>
  </tr>
%     endfor
</table>
%   endif

## IF DERIVED
% else:

<%
    alternation_values = list(
        DBSession.query(m.AlternationValue)
        .join(m.Verb)
        .join(m.CodingFrame, m.AlternationValue.derived_codingframe)
        .join(m.Alternation)
        .filter(m.Verb.basic_codingframe_pk == ctx.pk)
        .order_by(m.CodingFrame.pk)
        .distinct(m.CodingFrame.pk))
%>
%     if alternation_values:
<h3>Derived coding frames</h3>
<table class="table table-bordered" style="width:auto">
  <thead>
    <tr>
      <th>Derived coding frame</th>
      <th>via</th>
    </tr>
  </thead>
  <tbody>
    %     for val in alternation_values:
    <tr>
      <td>${h.link(request, val.derived_codingframe)}</td>
      <td>${h.link(request, val.alternation)}</td>
    </tr>
%   endfor
  </tbody>
</table>
%   endif

## IF DERIVED
% endif


% if ctx.description:
<p>${ctx.description | n}</p>
% endif

% if ctx.derived == 'Derived':

<h3>Verb forms occuring <em>regularly</em> in Alternations with this derived coding frame</h3>

## TODO table: | Microrole 1 | Microrole 2 | Microrole 3 |
${request.get_datatable('alternationvalues', m.AlternationValue, codingframe=ctx).render()}

% else:

<h3>Verb forms with this basic coding frame</h3>

## TODO table: | Microrole 1 | Microrole 2 | Microrole 3 |
${request.get_datatable('values', m.Verb, codingframe=ctx).render()}

% endif
