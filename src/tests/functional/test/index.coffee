#
# Make sure we can launch the index page.
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#
define [], () ->
  (browser, next) ->
    browser
      .chain
      .session()
      .open('/')
      .end (err) ->
        browser.testComplete ->
          next(err)