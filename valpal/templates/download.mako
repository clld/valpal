<%inherit file="home_comp.mako"/>
<%namespace name="mpg" file="clldmpg_util.mako"/>

<h3>Downloads</h3>

<p>
The data can be downloaded as a
${h.external_link('https://cldf.clld.org/', 'CLDF dataset')}
in the following places:
</p>

<ul>
  <li>
    A released version on Zenodo:<br>
    TODO
  </li>
  <li>
    A ${h.external_link('https://git-scm.com/', 'git')} repository with the most
    recent development version on GitHub:<br>
    ${h.external_link('https://github.com/lexibank/valpal', 'https://github.com/lexibank/valpal')}
  </li>
</ul>

<p>
Additionally, the source code for the web application can be found on GitHub
under:
${h.external_link('https://github.com/clld/valpal', 'https://github.com/clld/valpal')}
</p>
