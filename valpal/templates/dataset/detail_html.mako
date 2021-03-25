<%inherit file="../home_comp.mako"/>
<%namespace name="util" file="../util.mako"/>

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

<pre class="citation">
${citation.render(example_contribution, request).rstrip('\n')}
</pre>

<p>
The complete work should be cited as follows:
${h.button('BibTeX', onclick=h.JSModal.show('BibTeX citation', None, '<pre>{}</pre>'.format(bibtex.render(ctx, request))))}
</p>

<pre class="citation">
${citation.render(ctx, request).rstrip('\n')}
</pre>

<h3>Terms of use</h3>

The content of this web site is published under a
<a href="${ctx.license}">${ctx.jsondata['license_name']}</a>.
We invite the community of users to think about further applications for the
available data and look forward to your comments, feedback, and questions.
