#
# Main execution file for functional tests.
#
# Make sure you have completed the following before running:
#  1. Configure the proper main configuration and browsers in the "config" directory.
#  2. Run selenium server.
#        java -jar selenium-server.jar
#  3. Run the actual application.
#        node server.js
#  4. Run this file, including individual tests if desired (in order).
#        node app/tests/functional/run.js [test1 test2 ...]
#
# @see ./config
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#

#
requirejs = require('requirejs')

requirejs.config
  baseUrl: __dirname
  nodeRequire: require

requirejs ['async', 'config/main', 'fs', 'path'], (async, config, fs, path) ->

  #
  # Determine the absolute path to all of the functional tests.
  #
  async.waterfall [(next) ->
    # Run only individual tests, if requested (in order).
    if (process.argv.length > 2)
      return async.mapSeries process.argv.splice(2),
               ((test, subnext) ->
                 subnext(null, path.resolve(requirejs.toUrl('.') + '/test/' + test + '.js'))
               ), (err, tests) ->
                 next err, tests

    # Load all tests found in the "test" directory.
    tests = []
    dirList = [path.resolve(__dirname + '/test')]
    while dirList.length
      test = dirList.pop()

      # Continue if directory.
      if fs.statSync(test).isDirectory()
        dirList = dirList.concat(fs.readdirSync(test).map((file) -> path.resolve(test + '/' + file)))
        continue

      # Add our test to the tests list.
      tests.push test

    next null, tests

  #
  # Run all of the tests for each browser.
  #
  , (tests, next) ->

    requirejs ['config/browsers'], (browsers) ->
      async.forEachSeries browsers, ((browser, nextBrowser) ->
        requirejs ['config/browsers/' + browser], (browser) ->
          # Run browser as a function to actually init the browser.
          browser = browser config.host, config.port, config.url

          # Load the test and run!
          async.forEachSeries tests, ((test, nextTest) ->
            requirejs [test], (test) -> test(browser, nextTest)
          ), (err) ->
            nextBrowser err

      ), (err) ->
        next err

  #
  # Re-throw the error, if any occurred.
  #
  ], (err) ->
    throw err if err