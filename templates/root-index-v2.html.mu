<!DOCTYPE html>
<html lang="{{ language }}" class="h-feed hfeed">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{{ title }}{{_title_suffix}}</title>
    {{#keywords}}
    <meta name="keywords" content="{{ keywords }}" />
    {{/keywords}}
    <meta name="name" content="{{title}}" />
    {{#_image}}
    <meta name="image" content="{{{_image}}}" />
    {{/_image}}
    <meta
      name="description"
      content="{{{description}}}"
    />
    <meta property="og:url" content="{{{home_page_url}}}" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="{{ title }}" />
    {{#_image}}
    <meta property="og:image" content="{{{_image}}}" />
    <meta property="og:image:alt" content="{{ title }}" />
    {{/_image}}
    <meta property="og:description" content="{{ description }}" />
    <meta property="og:site_name" content="{{ title }}" />
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:site" content="@buzzingcc" />
    <meta name="twitter:url" content="{{{home_page_url}}}" />
    <meta name="twitter:title" content="{{ title }}" />
    <meta name="twitter:description" content="{{ description }}" />
    {{#_image}}
    <meta name="twitter:image" content="{{{_image}}}" />
    <meta name="twitter:image:alt" content="{{ title }}" />
    {{/_image}}
    <meta property="og:locale" content="{{ language }}" />
    {{#_rss_url}}
    <link
      rel="alternate"
      href="{{{_rss_url}}}"
      type="application/rss+xml"
      title="{{ title }}"
    />
    {{/_rss_url}}
    {{#_atom_url}}
     <link
      rel="alternate"
      href="{{{_atom_url}}}"
      type="application/atom+xml"
      title="{{ title }}"
    />
    {{/_atom_url}}
    <link
      rel="alternate"
      href="{{{feed_url}}}"
      type="application/feed+json"
      title="{{ title }}"
    />
    <link
      rel="apple-touch-icon"
      sizes="180x180"
      href="{{{icon}}}"
      type="image/png"
    />
    <link rel="icon" href="{{{favicon}}}" />
    <style>
      body {
        margin: 0 auto;
        padding: 0;
        max-width: 100%;
        line-height: 1.5em;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          Helvetica, sans-serif;
        background-color:rgb(255, 252, 249);
      }
      img {
        max-width: 95%;
        {{#_max_image_height}}
        max-height: {{_max_image_height}}px;
        {{/_max_image_height}}
        {{^_max_image_height}}
        max-height: 14em;
        {{/_max_image_height}}
        border-radius: 0.5em;
        height: auto;
      }
      video {
        max-width: 90%;
        max-height: 32em;
        height: auto;
      }
      .embed-video {
        aspect-ratio: 16 / 9;
        width: 85%;
      }
      .container{
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(22em, max-content));
        justify-items: center;
        grid-gap: 1.5em;
      }
      .card{
        height: 36em;
        min-width: 20em;
        max-width: 28em;
        background-color: #fff;
        box-shadow: 0 -0.5px 0.5px rgba(135, 116, 87,0.1),0 -0.5px 0.5px rgba(135, 116, 87,0.1),0 2px 1px rgba(135, 116, 87,0.1),0 10px 15px -5px rgba(135, 116, 87,0.1),0 2px 3px rgba(135, 116, 87,0.1);
        border: 0;
        overflow-y: scroll;
        padding: 0em;
        border-radius: 0.5em;
        scrollbar-width: none; /* Firefox */
        -ms-overflow-style: none;  /* Internet Explorer 10+ */
      }
      .card::-webkit-scrollbar { 
        display: none;  /* Safari and Chrome */
      }
      a:link {
        color: rgb(0, 102, 204);
      }
      a:hover {
        text-decoration: underline;
        color: rgb(0, 102, 204);
      }
      .header{
        padding-top: 0.5em;
        text-align: center;
      }
      .text-left{
        text-align: left;
        }
      .footer{
        margin-bottom: 2em;
        padding-left: 1em;
        padding-right: 1em;
        padding-top: 2em;
        text-align: center;
      }
      .article {
        padding: 4px 1em;
      }
      .article footer{
        {{#_is_lite}}
        margin-top: 0;
        {{/_is_lite}}
        {{^_is_lite}}
        margin-top: 0.5em;
        {{/_is_lite}}
      }

      .pre-line {
        white-space: pre-line;
      }
      .text-lg {
        font-size: 1.1em;
      }
      .my {
        margin-top: 0.675em;
        margin-bottom: 0.675em;
      }
      .small{
        font-size: 0.9375em;
      }
      .muted {
        color: #828282;
      }
      a.muted:link,a.muted:visited {
        color: #828282;
        text-decoration: none;
      }

      a.muted:hover{
        text-decoration: underline;
        color: rgb(0, 102, 204);
      }
      .secondary a:link,.secondary a:visited {
        color: #828282;
      }
      .secondary a:hover{
        color: rgb(0, 102, 204);
      }
      .italic{
        font-style: italic;
      }
      .contrast a:link,
      .contrast a:visited {
        color: initial;
      }
      .contrast a:hover {
        color: rgb(0, 102, 204);
      }
      a.contrast:link ,
      a.contrast:visited  {
        color: initial;
      }
      a.contrast:hover {
        color: rgb(0, 102, 204);
      }
      a.no-underline {
        text-decoration: none;
      }
      a.no-underline:hover {
        text-decoration: underline;
        color: rgb(0, 102, 204);
      }
      .no-underline > a{
        text-decoration: none;
      }
      .no-underline > a:hover{
        text-decoration: underline;
        color: rgb(0, 102, 204);
      }
      .details,
      .less,
      .more:target {
        display: none;
      }
      .more:target ~ .details {
        display: block;
      }
      .more:target ~ .less {
        display: inline;
      }

      .about-content,
      .less-about,
      .about:target {
        display: none;
      }
      .about:target ~ .about-content {
        display: block;
      }
      .about:target ~ .less-about {
        display: inline;
      }
      .bold {
        font-weight: 500;
      }
      .mb {
        {{#_is_lite}}
        margin-bottom: 4px;
        {{/_is_lite}}
        {{^_is_lite}}
        margin-bottom: 0.5em;
        {{/_is_lite}}
      }
      .mb-sm {
        {{#_is_lite}}
        margin-bottom: 2px;
        {{/_is_lite}}
        {{^_is_lite}}
        margin-bottom: 0.1em;
        {{/_is_lite}}
      }
      .px {
        padding-left: 1em;
        padding-right: 1em;
      }
      .px-l{
        padding-left: 1.5em;
        padding-right: 1.5em;
        }
      .px-lg{
        padding-left: 2em;
        padding-right: 2em;
        }
      .border-bottom {
        height: 1px;
        border-bottom: 1px dashed #d4d4d4;

      }
      .flex{
        display: flex;
      }
      .justify-between{
        justify-content: space-between;
        }
      .w-50 {
        width: 50%;
      }
      .w-prefix{
        width: 50px;
      }
      .pl-prefix {
        padding-left: 50px;
      }
      .fixed{
        position: fixed;
        bottom: 2em;
        right: 0.5em;
        font-weight: bold;
        z-index:1;
      }
      .text-center{
        text-align: center;
      }
      .inline-block{
        display: inline-block;
      }
      .nsfw{
        color: #d10023;
        font-size:small;
      }
      .mt0{
        margin-top: 0;
      }
      @media (max-width: 480px) {
        .container{
          display: block;
        }
        .card {
          margin-bottom: 1.5em;
        }
      }
      @media print{
        .fixed{
            display: none;
        }
        header{
            display: none;
        }
        .footer{
            display: none;
        }
      }
    </style>
  </head>
  <body>
    <div id="top"></div>
    <header class="header px-l">
    <div>
      <a class="contrast no-underline small" href="{{{_site_url}}}">{{
        _site_title
      }}</a>
      <span> · </span>
      <a id="about" href="#about" class="about muted small">{{
        about_label
      }}</a>
      <a href="#" class="less-about muted small">{{ less_label }}</a>
      <span> · </span>
      {{#_related_sites}}
      <a class="muted small" href="{{{url}}}">{{ name }}</a
      >{{^is_last}}<span> · </span>{{/is_last}}
      {{/_related_sites}}
      {{#_other_sites.0}}
      <a id="more" href="#more" class="more muted small">+ {{ more_label }}</a>
      <a id="less" href="#" class="less muted small">- {{ less_label }}</a>
      <div class="details small">
        {{/_other_sites.0}} {{#_other_sites}}
        <a class="muted" href="{{{url}}}">{{ name }}</a
        >{{^is_last}}<span> · </span>{{/is_last}} {{/_other_sites}}
        {{#_other_sites.0}}
      </div>
      {{/_other_sites.0}}
      <div class="text-left about-content contrast small">
        <p class="p-summary site-description">{{ description }}</p>
        <div>
        {{#_versions.1}}
        {{ version_label }}: {{#_versions}} {{#active}}
          <span>{{ name }}</span>
          {{/active}} {{^active}}
          <a href="{{{url}}}">{{ name }} </a>
          {{/active}} {{/_versions}}
          <br />
        {{/_versions.1}}
                 {{ languages_label }}:
          <ul>
          {{#_languages}}
            <li>
              {{#active}}
                <span>{{ name }}</span>
              {{/active}}
              {{^active}}
                <a href="{{{url}}}">{{ name }}</a>
              {{/active}}
            </li>
          {{/_languages}}
          </ul>
          {{ subscription_label }}:
          <ul>
          {{#_atom_url}}
            <li><a href="{{{_atom_url}}}">Atom/RSS Feed</a></li>
          {{/_atom_url}}
          {{#feed_url}}
            <li><a href="{{{feed_url}}}">JSON Feed</a></li>
          {{/feed_url}}
          </ul>
          {{social_label}}:
          <ul>
          {{#_social_links}}<li><a href="{{url}}">{{name}}</a></li>{{/_social_links}}
          </ul>
          {{#_sources.0}}
          {{ sources_label }}:
           <ul>
          {{#_sources}}<li><a href="{{url}}">{{name}}</a></li>{{/_sources}}
          </ul>
          {{/_sources.0}}
          {{latest_build_at_lable}}: {{_latest_build_time}} &nbsp; <a href="/stats/">{{stat_label}}</a>
          <br />
          {{ powered_by_label }}:
          <a href="https://www.owenyoung.com">Owen</a> (<a href="https://twitter.com/OwenYoungZh">Twitter</a>)
        </div>
      </div>
      {{#_page_title}}
      <h3>{{.}}</h3>
      {{/_page_title}}
      </div>
    </header>
    {{#_groups}}
      <details open id="{{title}}" class="categories">
      <summary class="px-lg my bold">{{title}}</summary>
    <div class="container px-l">
      {{#items}}
      <div class="card w-card">
      <p class="px my bold"><a class="contrast no-underline" href="{{{home_page_url}}}">{{{title}}}</a> <span class="muted">-</span> <a href="{{home_page_url}}" class="muted small">{{hostname}}</a> </p>
      {{#items}}
      <div class="article h-entry hentry">
      <div class="mb-sm mt0">
        <a class="p-name entry-title bold small no-underline u-url" href="{{{url}}}">{{#order}}<span>{{ . }}. </span>{{/order}}{{{title}}}</a>{{#_sensitive}}<span>&nbsp;(</span><span class="nsfw small">NSFW</span><span>)</span>{{/_sensitive}}{{#_links}}&nbsp;<a class="no-underline muted small" href="{{{url}}}">{{{name}}}</a>{{/_links}}</div>
      <div class="no-underline p-summary entry-summary secondary pre-line small italic">{{{content_html}}}</div>
      </div>
      {{/items}}
      {{#remaining_count}}
      <div class="mb article muted secondary small">
        <a href="{{{home_page_next_url}}}">{{{remaining_label}}}</a>
        <span>&nbsp;</span><a class="small" href="{{{home_page_next_lite_url}}}">{{{Lite}}}</a><span>&nbsp;·&nbsp;</span><a class="small" href="{{{atom_url}}}">{{{subscription_label}}}</a> <span></span>
      </div>
      {{/remaining_count}}
    </div>
    {{/items}}
    </div>
    </details>
    {{/_groups}}
    <footer class="footer">

      <a class="muted" href="{{{_advice_url}}}">{{{advice_label}}}</a>

    </footer>
    <div id="bottom"></div>
    <div class="fixed">
      <div class="mb">
        <a class="no-underline contrast" title="Go to Top" href="#top">&uarr;</a>
      </div>
      <div>
        <a class="no-underline contrast" title="Go to Bottom" href="#bottom">&darr;</a>
    </div>
   </div>
   <script>
      // close details element
      var elements = document.querySelectorAll(".categories")
      var localstorageKey = 'buzzing_closed_ids';
      var currentClosedIds = localStorage.getItem(localstorageKey) || "";
      var currentClosedIdsArray = currentClosedIds.split(",").filter(element => element);
      for (var i=0;i<currentClosedIdsArray.length;i++){
        var id = currentClosedIdsArray[i];
        if (id){
          var element = document.getElementById(id);
          if (element){
            element.removeAttribute("open");
          }
        }
      }
      elements.forEach((element) => {
        element.addEventListener("toggle", function (event) {
          var targetId = event.target.id
          var targetStatus = event.target.open
          // save to localStorage
          // only save the close status
          var originalClosedIds = localStorage.getItem(localstorageKey) || "";
          var closedIdsArray = originalClosedIds.split(",").filter(element => element);
          var isChanged = false;
          if (targetStatus){
            // remove from localStorage
            var index = closedIdsArray.indexOf(targetId);
            if (index > -1) {
              closedIdsArray.splice(index, 1);
              isChanged = true;
            }

          }else{
            // add to localStorage
            // check unique 
            if (closedIdsArray.indexOf(targetId) == -1){
              closedIdsArray.push(targetId);
              isChanged = true;
            }

          }
          if (isChanged){
            var newClosedIds = closedIdsArray.join(",");
            localStorage.setItem(localstorageKey, newClosedIds);
          }
          
        })
      })
   </script>
</body>
</html>
