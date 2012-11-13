#
# Main execution file for functional tests.
#
# Make sure you have completed the following before running:
#  1. Configure the proper tests and browsers in the "config" directory.
#  2. Run selenium server (java -jar selenium-server.jar).
#  3. Run the actual application (node server.js).
#  4. Run this file (node app/tests/functional/run.js)
#
# @see ./config
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#
requirejs = require('requirejs')

requirejs.config
  baseUrl: __dirname
  nodeRequire: require

requirejs ['async', 'config/main', 'config/browsers', 'config/tests'], (async, config, browsers, tests) ->
  async.forEachSeries browsers, ((browser, next) ->

    requirejs ['config/browsers/' + browser], (browser) ->
      # Run browser as a function to actually init the browser.
      browser = browser(config.host, config.port, config.url)

      async.forEachSeries tests, ((test, subnext) ->

        requirejs ['test/' + test], (test) ->test(browser, subnext)

      ), (err) ->
        next(err)

  ), (err) ->
    throw err if err