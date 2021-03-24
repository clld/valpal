<%inherit file="../home_comp.mako"/>
<%namespace name="util" file="../util.mako"/>

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

<h3>How to cite ValPaL</h3>

<p>
The ValPaL online database is an edited database consisting of different
languages which should be regarded as separate publications, like chapters of an
edited volume.
These datasets exemplified by
<a href="${request.resource_url(example_contribution)}">Icelandic</a> should be
cited as follows:
</p>

<pre>
${citation.render(example_contribution, request).rstrip('\n')}
</pre>

<p>The complete work should be cited as follows:</p>
## TODO: BibTeX link

<pre>
${citation.render(ctx, request).rstrip('\n')}
</pre>
