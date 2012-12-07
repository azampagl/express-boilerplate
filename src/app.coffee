# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Main application.
#
#     requirejs ['app'], (App) ->
#       App(app) ->
#         console.log app // app is the actual instance of the app.
#

#
define ['async', 'express', 'fs', 'path', 'require', 'libs/i18n', 'libs/logger', 'libs/theme'], (async, express, fs, path, requirejs, i18n, logger, theme) ->
  (done) ->
	# Find the root of the app.
    root = path.resolve(requirejs.toUrl('.'), '..')

    # Load the package.json file for config settings.
    pkg = JSON.parse fs.readFileSync(path.resolve(root + '/package.json'))

    # Init express.
    app = express()

    async.series [(next) ->
      app.configure ->
	    # View engine.
        app.set 'views', path.resolve(root + '/views')
        app.set 'view engine', 'jade'
        # Static file serving.
        app.use express.compress()
        app.use express.static(path.resolve(root + '/public'))
        # Body parsing.
        app.use express.bodyParser(uploadDir: path.resolve(root + '/public/' + pkg.config.main.cfd))
        app.use express.methodOverride()
        # Cookies and session support.
        app.use express.cookieParser(pkg.config.main.cookieSecret);
        app.use express.cookieSession();
        # CSRF
        app.use express.csrf()
        # Dynamic/Static helpers.
        app.use (req, res, subnext) ->
          locals = res.locals.app || {}
          locals.BASE_URL = req.protocol + '://' + req.get('host') + pkg.config.main.base_url
          locals.CFD = req.protocol + '://' + pkg.config.main.cfd + '.' + req.get('host').replace('www.', '')
          locals.HOST = req.get('host')
          locals.LANGS = pkg.config.i18n.langs
          locals.PROTOCOL = req.protocol
          locals.THEME = theme.theme
          locals.URL = req.url
          locals.VERSION = pkg.version

          locals.CFD_THEME = locals.CFD + '/' + locals.THEME

          res.locals.app = locals

          subnext()

        # i18n middleware.
        app.use i18n.middleware()
        # Theme middleware.
        app.use theme.middleware()
        # Router.
        app.use app.router

        next()

    , (next) ->
      # In development, display errors.
      app.configure 'development', ->
        app.use express.errorHandler(
          dumpExceptions: true
          showStack: true
        )
        next()

      # In production, handle errors cleanly.
      app.configure 'production', ->	
        # Page not found.
        app.use (req, res, subnext) ->
          res.status 404
          if req.accepts('html')
            i18n.view('route-404') req, res, -> res.theme '404'
          else
            res.send()

        # Error catching.
        app.use (err, req, res, subnext) ->
          res.status 500
          if req.accepts('html')
	          i18n.view('route-500') req, res, -> res.theme '500'
          else
              res.send()

          logger.error(err.stack)

        next()
    , (next) ->

      # Redirect to www, if necessary.
      app.all '*', (req, res, next) ->
         if req.get('host').match(/^www/) == null
           res.redirect(req.protocol + '://www.' + req.get('host'))
         else
           next()

      # Load the custom router lib.
      requirejs ['libs/router'], (Router) ->
        routes = [path.resolve(root + '/app/routes')]

        while routes.length
          route = routes.pop()

          # Continue if the route is a directory.
          if fs.statSync(route).isDirectory()
            routes = routes.concat(fs.readdirSync(route).map((file) -> path.resolve(route + '/' + file)))
            continue

          # Load our actions.  Place inside a anon function so "route" isn't
          #  overwritten in our while loop.
          ((route) ->
            requirejs [route], (actions) ->
              # Remove the .js from the the route.
              route = route.replace(/.+\/routes\//, '').match(/(.*)\.[^.]+$/)[1]
              # Map the routes.
              Router.map(app, route, actions)
          )(route)

        next()
    ], () ->
	  # Done with our app initialization.
      done(app)