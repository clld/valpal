<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<% from clld.db.meta import DBSession %>
<% import valpal.models as m %>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "codingframes" %>


% if ctx.derived == 'Derived':
<h2>Derived coding frame</h2>
% else:
<h2>Basic coding frame</h2>
% endif:

<p>Schema: ${ctx.name}</p>

% if ctx.description:
<p>${ctx.description | n}</p>
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
    <td>${index_number.argument_type}</td>
  </tr>
  % endfor
</tbody>
</table>
% endif

<h3>Verb forms with this basic coding frame</h3>

## TODO table
## | Verb form | Meaning | Microrole 1 | Microrole 2 | Microrole 3 |
