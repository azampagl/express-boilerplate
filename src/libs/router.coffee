# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Custom router for RESTful routes in express.
#

#
define ['libs/i18n', 'underscore'], (i18n, _) ->

  #
  # # map() #
  # 
  # Maps a routes actions to the proper express routes.
  #
  # Assuming we call router.map on 'routes/foo.js' (which contains actions),
  # 
  #     router.map('foo', { ... })
  # 
  # express would recognize the following routes: 
  #
  #     // Called before every route under /foo/*
  #     before: (req, res, next) ->
  #       console.log('Before called.')
  #       next()
  #
  #     // GET /foo/foo
  #     // Use route middleware (another view).
  #     '/foo/foo':
  #       index: [i18n.view('routes/foo/nls/index'), (req, res) ->
  #         res.theme 'foo/foo'
  #     ]
  #
  #     // GET /foo/bar
  #     'bar':
  #       index: (req, res) ->
  #         res.render 'foo/bar'
  #
  #     // GET /foo
  #     index: (req, res) ->
  #	      res.render 'foo/index'
  #
  #     // GET /foo/new
  #     new: (req, res) ->
  #	      res.render 'foo/new'
  #     
  #     // POST /foo
  #     create: (req, res) ->
  #	      req.body
  #       res.send 200
  #     
  #     // GET /foo/:id
  #     show: (req, res) ->
  #       res.render 'foo/show'
  #         id: req.params.id
  #     
  #     // GET /foo/:id/edit
  #     edit: (req, res) ->
  #       res.render 'foo/edit'
  #         id: req.params.id
  #     
  #     // PUT /foo/:id
  #     update: (req, res) ->
  #	      req.params.id
  #	      req.body
  #       res.send 200
  #     
  #     // DELETE /foo/:id
  #     destroy: (req, res) ->
  #   	  req.params.id
  #       res.send 200
  # 
  map: (app, base, routes) ->
    # URI
    uri = base    
    uri = '/' + base if base[0] != '/'

	# Before action.
    app.all uri + '*', routes.before if routes.before
    
    for route of routes
      # Reserved words.
      continue if route == 'before'

      # Location of the i18n view.
      i18nView = 'routes' + uri + '/nls'

      # Get the action from our route.
      action = routes[route]
      middleware = []

      # If the action is an array, we have middleware to process as well.
      if _.isArray(action)
        middleware = action[0..(action.length - 2)]
        action = action.pop()

      # Standard REST methods.
      switch route
        when 'index'
          app.get uri, [i18n.view(i18nView + '/index')].concat(middleware), action
        when 'new'
          app.get uri + '/new', [i18n.view(i18nView + '/new')].concat(middleware), action
        when 'create'
          app.post uri, [i18n.view(i18nView + '/create')].concat(middleware), action
        when 'show'
          app.get uri + '/:id', [i18n.view(i18nView + '/show')].concat(middleware), action
        when 'edit'
          app.get uri + '/:id/edit', [i18n.view(i18nView + '/edit')].concat(middleware), action
        when 'update'
          app.put uri + '/:id', [i18n.view(i18nView + '/update')].concat(middleware), action
        when 'destroy'
          app.del uri + '/:id', [i18n.view(i18nView + '/destroy')].concat(middleware), action
        else
          # Check for absolute route.
          if route[0] is '/' then newUri = route else newUri = uri + '/' + route

          @map(app, newUri, action)