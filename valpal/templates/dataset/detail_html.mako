<%inherit file="../home_comp.mako"/>

<%def name="sidebar()">
    <div class="well">
        <h3>Sidebar</h3>
        <p>
            Content
        </p>
    </div>
</%def>

<h2>Welcome to ValPaL</h2>

<p class="lead">The Valency Patterns Leipzig Online Database</p>

<p class="colab">
    <a href="http://www.dfg.de/">
        <img id="home-dfg-logo" alt="DFG" src="${request.static_url('valpal:static/dfg_logo.jpg')}" />
    </a>
    +
    <a href="http://www.eva.mpg.de/">
        <img id="home-eva-logo" alt="MPI-EVA" src="${request.static_url('valpal:static/logo_minerva.png')}"/>
    </a>
    +
    <img id="home-valency-logo" alt="Valency Project" src="${request.static_url('valpal:static/logo_valency.png')}"/>
    ⇒
    <a href="${request.route_url('contributions')}">
        <img id="home-valpal-logo" alt="ValPaL" src="${request.static_url('valpal:static/logo_valpal_text.png')}"/>
    </a>
</p>
