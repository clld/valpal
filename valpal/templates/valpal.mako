<%inherit file="app.mako"/>

<%block name="brand">
    <a href="${request.route_url('dataset')}" class="brand">
        <img alt="ValPal" src="${request.static_url('valpal:static/logo_valpal_100.png')}" />
    </a>
</%block>

${next.body()}
