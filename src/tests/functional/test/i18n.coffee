#
# Test the i18n page (change languages).
#
#  1. Launch the homepage.
#  2. Make sure the title says "Title".
#  3. Use the drop down box on the navbar to change the language to spanish.
#  4. Make sure a cookie exists for "lang" (and that it equals "es").
#  5. Make sure the title says "Título".
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#
define [], () ->
  (browser, next) ->
    browser
      .chain
      .session()
      .open('/')
      .assertTitle('Title')
      .clickAndWait('link=Español (España)')
      .assertCookiePresent('lang')
      .assertCookieByName('lang', 'es')
      .assertTitle('Título')
      .end (err) ->
        browser.testComplete ->
          next(err)