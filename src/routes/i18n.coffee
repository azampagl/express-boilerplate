# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Routes responsible for changing the current language of the browser.
#

#
define ['libs/i18n'], (i18n) ->

  #
  # # GET /i18n/:id #
  #
  # Set the current browser's language to the desired id.
  #
  show: (req, res) ->
    # Never cache this page.
    res.set 'Cache-Control', 'no-cache'
	
    # Make sure the language is supported.
    if req.params.id in res.locals.app.LANGS
      # Save the id to the cookies.
      i18n.cookie(req, res, req.params.id)
      # If the request is json, send a success response.
      return res.send 200 if req.is('json')
      # Otherwise, redirect the user back to the page they were on.
      return res.redirect 301, req.headers.referer

    # Bad request.
    res.send 400