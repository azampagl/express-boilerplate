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
    # Log to console for services like nodejitsu.
    new (winston.transports.Console)(),
    # Log to a file in the local project.
    new (winston.transports.File)(level: 'error', filename: path.resolve(pkg.config.main.logDir + '/error.log'))
  ])