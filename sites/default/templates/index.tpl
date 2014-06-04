<!DOCTYPE html>

<html lang="en">

  <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <link href="//fonts.googleapis.com/css?family=PT+Serif" rel="stylesheet" type="text/css">
    <link href="//fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet" type="text/css">
    <link href="//fonts.googleapis.com/css?family=Source+Code+Pro" rel="stylesheet" type="text/css">

    {{ if .IsHome }}
        <title>{{ setting "page/head/title" }}</title>
    {{ else }}
      {{ if .Title }}
        <title>
          {{ .Title }} {{ if setting "page/head/title" }} - {{ setting "page/head/title" }} {{ end }}</title>
      {{ else }}
        <title>{{ setting "page/head/title" }}</title>
      {{ end }}
    {{ end }}

		<link rel="shortcut icon" href="{{ asset "/favicon.png" }}" />

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

    <link rel="stylesheet" href="//menteslibres.net/static/normalize/normalize.css" />

    <link rel="stylesheet" href="//menteslibres.net/static/bootstrap/css/bootstrap.css" />

    <link rel="stylesheet" href="//menteslibres.net/static/highlightjs/styles/solarized_dark.css">
    <script src="//menteslibres.net/static/highlightjs/highlight.pack.js"></script>

    <link rel="stylesheet" href="{{ asset "/css/styles.css" }}" />

    <script type="text/javascript" src="{{ asset "/js/main.js" }}"></script>

		<style type="text/css">
			body {
				font-family: 'PT Sans';
				font-size: large;
			}
			code {
				font-family: 'Source Code Pro';
			}
			img.textsize {
				height: 1.5em;
			}
		</style>

  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">

          <a class="brand" href="{{ asset "/" }}"><img style="height: 25px; padding: none;" src=/images/logo.png />  {{ setting "page/brand" }}</a>

          <div class="nav-collapse">
            {{ if settings "page/body/menu" }}
              <ul id="nav" class="nav menu">
                {{ range settings "page/body/menu" }}
                  <li>{{ link .url .text }}</li>
                {{ end }}
              </ul>
            {{ end }}
            {{ if settings "page/body/menu_pull" }}
              <ul id="nav" class="nav pull-right menu">
                {{ range settings "page/body/menu_pull" }}
                  <li>{{ link .url .text }}</li>
                {{ end }}
              </ul>
            {{ end }}
          </div>

        </div>
      </div>
    </div>

    <div class="container" id="container">

    {{ if .IsHome  }}

      <div class="hero-unit">

        <h1>Gestii Knowledge Base</h1>
        <p>Bienvenido a la base de conocimiento de Gestii. Para navegar, elija una categoría en la barra superior.</p>

<!--
        <p class="pull-right">
          <a href="http://luminos.menteslibres.org" target="_blank" class="btn btn-large btn-primary">
            Homepage
          </a>
        </p>
-->

      </div>

      <div class="container-fluid">
        <div class="row">
          <div class="span11">
            {{ .ContentHeader }}

            {{ .Content }}

            {{ .ContentFooter }}
          </div>
        </div>
      </div>

    {{ else }}

      {{ if .BreadCrumb }}
        <ul class="breadcrumb menu">
          {{ range .BreadCrumb }}
            <li><a href="{{ asset .link }}">{{ .text }}</a> <span class="divider">/</span></li>
          {{ end }}
        </ul>
      {{ end }}

      <div class="container-fluid">

        <div class="row">
          {{ if .SideMenu }}
            {{ if .Content }}
              <div class="span3">
                  <ul class="nav nav-list menu">
                    {{ range .SideMenu }}
                      <li>
                        <a href="{{ asset .link }}">{{ .text }}</a>
                      </li>
                    {{ end }}
                  </ul>
              </div>
              <div class="span8">
                {{ .ContentHeader }}

                {{ .Content }}

                {{ .ContentFooter }}
              </div>
            {{ else }}
              <div class="span11">
                {{ if .CurrentPage }}
                  <h1>{{ .CurrentPage.text }}</h1>
                {{ end }}
                <ul class="nav nav-list menu">
                  {{ range .SideMenu }}
                    <li>
                      <a href="{{ asset .link }}">{{ .text }}</a>
                    </li>
                  {{ end }}
                </ul>
              </div>
            {{ end }}
          {{ else }}
            <div class="span11">
              {{ .ContentHeader }}

              {{ .Content }}

              {{ .ContentFooter }}
            </div>
          {{ end }}
        </div>

      </div>

    {{ end }}
    </div>

    <div id="help"><center>
    <h3 id="help-trigger">¿Necesitas ayuda?</h3>
    <p id="help-text">Escríbenos a <a href="#">soporte@gestii.com</a> o llámanos a la línea de atención telefónica Gestii al <strong>+52 (55) 4438 0011</strong>.</p>
    </center></div>

    <div id="auronix"><center>
    <img src="/images/logos/auronix_footer.png">
    <br /> <br />
    <p class="small">Hda. de Coaxamalucan #145. Hacienda de Echegaray, Naucalpan, México DF, 53300. México.</p>
    <p class="small">Proteger la seguridad y privacidad de tu información es muy importante para Auronix, por lo tanto ofrecemos nuestros servicios de acuerdo a las leyes aplicables en materia de protección de la privacidad y seguridad de datos. Para ayudarte a entender los datos que Gestii puede recopilar, cómo Gestii los utiliza y qué garantías ofrecemos sobre ellos, por favor consulta nuestra política de privacidad.</p>
    <p class="small">Gestii es marca registrada de Auronix. Todos los derechos reservados.</p>
    </center></div>

    {{ if setting "page/body/scripts/footer" }}
      <script type="text/javascript">
        {{ setting "page/body/scripts/footer" | jstext }}
      </script>
    {{ end }}

  </body>
</html>
