# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Theme middleware for the express framework.
# 
#     // Use
#     res.theme('index');
#     // instead of (assuming you are using theme 'default')
#     res.render('default/index')
#

#
define [], () ->

  #
  # # theme #
  # 
  # The default theme.
  #
  theme: 'default'

  #
  # # middleware() #
  #
  # Middleware function for the express framework use function.
  #
  #     app.use theme.middleware()
  #
  middleware: ->
    (req, res, next) =>
      res.theme = (view, options, fn) => res.render(@theme + '/' + view, options, fn)
      next()