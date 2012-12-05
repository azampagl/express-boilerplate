# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Homepage routes.
#

#
define [], () ->

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