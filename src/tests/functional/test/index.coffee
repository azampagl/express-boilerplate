#
# Make sure we can launch the index page.
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*

#
define [], () ->
  (browser, done) ->
    browser
      .chain
      .session()
      .open('/')
      .end (err) ->
        browser.testComplete ->
          done(err)