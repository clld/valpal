<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<% import valpal.models as m %>
<% from clld.web.maps import LanguageMap %>
<%! active_menu_item = "contributions" %>

<h2>${ctx.name}</h2>

${util.data()}

<div class="tabbable">

    <ul class="nav nav-tabs">
        <li class="active"><a href="#about" data-toggle="tab">Introduction</a></li>
        <li><a href="#verbs" data-toggle="tab">${_('Values')}</a></li>
        <li><a href="#codingframes" data-toggle="tab">Coding frames</a></li>
        <li><a href="#codingsets" data-toggle="tab">Coding sets</a></li>
        <li><a href="#alternations" data-toggle="tab">Alternations</a></li>
        <li><a href="#examples" data-toggle="tab">${_('Sentences')}</a></li>
    </ul>

    <div class="tab-content">
        <div id="about" class="tab-pane active">
            <div class="span8">

                <h3>Contributors</h3>
                <ul>
                    % for c in ctx.contributor_assocs:
                    <li><a href="${request.resource_url(c.contributor)}">${c.contributor.name}</a></li>
                    % endfor
                </ul>

                <h3>
                    How to cite the ${ctx.name} dataset
                    ${h.button('BibTeX', onclick=h.JSModal.show('BibTeX citation', None, '<pre>{}</pre>'.format(bibtex.render(ctx, request))))}
                </h3>
                <pre class="citation">${citation.render(ctx, request).rstrip('\n')}</pre>

                % if ctx.language.markup_description:
                <h3>Comments</h3>

                ${ctx.language.markup_description|n}
                % endif
            </div>
            <div class="span4">
            <div class="well well-small">
                ${LanguageMap(ctx.language, request).render()}
                ${h.format_coordinates(ctx.language)}
                <hr>
                <table class="table-unstyled language-details">
                    % if ctx.language.glottocode:
                    <tr>
                    <th>Glottocode</th>
                    <td>${h.external_link(h.glottolog_url(ctx.language.glottocode), label=ctx.language.glottocode)}</td>
                    </tr>
                    % endif
                    % if ctx.language.iso_code:
                    <tr>
                    <th>ISO 639-3 code</th>
                    <td>${h.external_link('https://iso639-3.sil.org/code/{}'.format(ctx.language.iso_code), label=ctx.language.iso_code)}</td>
                    </tr>
                    % endif
                    % if ctx.language.family:
                    <tr><th>Family</th><td>${ctx.language.family.name}</td></tr>
                    % endif
                    % if ctx.language.macroarea:
                    <tr><th>Region</th><td>${ctx.language.macroarea}</td></tr>
                    % endif
                </table>
            </div>
            </div>
        </div>
        <div id="verbs" class="tab-pane">
            ${request.get_datatable('values', m.Verb, contribution=ctx).render()}
        </div>
        <div id="codingframes" class="tab-pane">
            ${request.get_datatable('codingframes', m.CodingFrame, contribution=ctx).render()}
        </div>
        <div id="codingsets" class="tab-pane">
            ${request.get_datatable('codingsets', m.CodingSet, contribution=ctx).render()}
        </div>
        <div id="alternations" class="tab-pane">
            ${request.get_datatable('alternations', m.Alternation, contribution=ctx).render()}
        </div>
        <div id="examples" class="tab-pane">
            ${request.get_datatable('sentences', h.models.Sentence, contribution=ctx).render()}
        </div>
    </div>

    <script>
$(document).ready(function() {
    if (location.hash !== '') {
        $('a[href="#' + location.hash.substr(2) + '"]').tab('show');
    }
    return $('a[data-toggle="tab"]').on('shown', function(e) {
        return location.hash = 't' + $(e.target).attr('href').substr(1);
    });
});
    </script>

</div>
