<%inherit file="home_comp.mako"/>
<% from clld.db.meta import DBSession %>
<% import valpal.models as m %>
<%namespace name="util" file="util.mako"/>

<h2></h2>

<table id="terms" class="table table-bordered table-striped">
  <thead>
    <tr>
      <th>Term</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
  % for term in DBSession.query(m.Term).order_by(m.Term.name):
    <tr><td>${term.name}</td><td>${term.description}</td></tr>
  % endfor
  </tbody>
</table>
