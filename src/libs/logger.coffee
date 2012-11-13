# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Initializes winston as the default logger.
#
  
#
define ['fs', 'path', 'winston'], (fs, path, winston) ->
  # Find the root of the app.
  root = path.resolve(requirejs.toUrl('.'), '..')

  # Load the package.json file for config settings.
  pkg = JSON.parse fs.readFileSync(path.resolve(root + '/package.json'))
  
  new (winston.Logger)(transports: [
    new (winston.transports.File)(level: 'error', filename: path.resolve(pkg.config.logDir + '/error.log'))
  ])