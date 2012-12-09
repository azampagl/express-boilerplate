# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Theme middleware for the express framework.
# 
#     // Use
#     res.theme('index') // Same as res.render('default/index')     
#
#     // Set a specific theme for this response.
#     res.themeName = 'default2'
#     res.theme('index') // res.render('default2/index)
#

#
define [], () ->

  #
  # # theme #
  # 
  # The default theme.
  #
  themeName: 'default'

  #
  # # middleware() #
  #
  # Middleware function for the express framework use function.
  #
  #     app.use theme.middleware()
  #
  middleware: ->
    (req, res, next) =>
      # Default to the standard theme name.
      themeName = @themeName

      # See if response-specific theme was set.
      if res.themeName
        themeName = res.themeName

      res.theme = (view, options, fn) => res.render(themeName + '/' + view, options, fn)
      next()