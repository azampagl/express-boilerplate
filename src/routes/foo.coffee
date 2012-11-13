# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Example routes.
#

#
define ['libs/i18n'], (i18n) ->

  #
  # # before #
  #
  # Executed before every "/foo/*" route.
  #
  before: (req, res, next) ->
    console.log('Before called.')
    next()

  #
  # # GET /foo/foo #
  #
  '/foo/foo':
    index: [i18n.view('routes/foo/nls/index'), (req, res) ->
      res.theme 'foo/foo'
    ]

  #
  # # GET /foo/bar #
  #
  'bar':
    index: (req, res) ->
      res.theme 'foo/bar'

  #
  # # GET /foo #
  #
  index: (req, res) ->
    res.theme 'foo/index'

  #
  # # GET /foo/new #
  #
  new: (req, res) ->
    res.theme 'foo/new'

  #
  # # POST /foo #
  #
  create: (req, res) ->
    req.body
    res.send 200

  #
  # # GET /foo/:id #
  #
  show: (req, res) ->
    res.theme 'foo/show',
      id: req.params.id

  #
  # # GET /foo/:id/edit #
  #
  edit: (req, res) ->
    res.theme 'foo/edit'
      id: req.params.id

  #
  # # PUT /foo/:id #
  #
  update: (req, res) ->
    req.params.id
    req.body
    res.send 200

  #
  # # DELETE /foo/:id #
  #
  destroy: (req, res) ->
    req.params.id
    res.send 200