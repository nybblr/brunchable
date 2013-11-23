exports.config =
  # See http://brunch.io/#documentation for docs.
  paths:
    watched: ['client']
  files:
    javascripts:
      joinTo: 'app.js'
      order:
        before: [
          "vendor/scripts/auto-reload.js"
        ]
    stylesheets:
      joinTo: 'app.css'
    templates:
      joinTo: 'app.js'
  server:
    path: 'app.coffee'
    port: 3000
    base: '/'
    run: yes
  plugins:
    autoReload:
      enabled:
        css: on
        js: on
        assets: true
