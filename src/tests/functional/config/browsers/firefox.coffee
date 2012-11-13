#
# Selenium firefox config.
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#
define ['soda'], (soda) ->
  (host, port, url) ->
    soda.createClient(
      host: host
      port: port
      url: url
      browser: 'firefox'
    )