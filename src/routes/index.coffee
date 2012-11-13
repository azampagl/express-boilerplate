# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Homepage routes.
#

#
define ['config/langs'], (langs) ->

  #
  # # / #
  #
  # Base routes.
  #
  '/':

    #
    # # /* #
    #
    # Called before every route.
    #
    before: (req, res, next) ->
	  
      # Store the languages in every page.
      res.locals.common = res.locals.common or {}
      res.locals.common.langs = langs

      next()

    #
    # # GET / #
    # 
    # Homepage.
    #
    index: (req, res) ->
      res.theme 'index',
        # Javascript variables for the page.
        javascript:
          index: true

  #
  # # GET /error #
  #
  # Demonstrate an error.
  #
  '/error':
    index: (req, res) ->
      i = variable.notexist
      res.send(200)