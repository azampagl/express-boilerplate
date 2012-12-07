#
# RequireJS bootstrap.
#
# Initializes our application variables and hard dependencies.
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#

# Top level application reference.
window.app = window.app or {}

# Base URL.
window.app.BASE_URL = window.app.BASE_URL or window.location.protocol + '//' + window.location.host

# Cookie Free Domain.
window.app.CFD = window.app.CFD or window.app.BASE_URL

# Vendor URL (location of bootstrap, backbone, etc).
window.app.VENDOR_URL = window.app.VENDOR_URL or window.app.CFD + '/vendor'

# Theme.
window.app.THEME = window.app.THEME or 'default'

# Cookie Free Domain Theme.
window.app.CFD_THEME = window.app.CFD_THEME or window.app.CFD + '/' + window.app.THEME

window.app.requirejs = requirejs.config
  baseUrl: window.app.CFD_THEME + '/js'
  paths:
    'vendor': window.app.VENDOR_URL
    'vendor/backbone': window.app.VENDOR_URL + '/backbone/backbone-0.9.2.min'
    'vendor/bootstrap': window.app.VENDOR_URL + '/bootstrap/bootstrap-2.2.1/js/bootstrap.min'
    'vendor/underscore': window.app.VENDOR_URL + '/underscore/underscore-1.4.3.min'
  shim:
    'vendor/backbone':
      deps: ['vendor/underscore']
  # Append our version number to every item so we can bust the cache if necessary.
  urlArgs: 'v=' + window.app.VERSION

# Load our two hard dependencies.
window.app.requirejs ['vendor/bootstrap', 'vendor/backbone'], ->

  # Set/Get X-CSRF-Token before sending/after receiving ajax calls.
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', window.app.CSRF
    complete: (xhr) ->
      window.app.CSRF = xhr.getResponseHeader('X-CSRF-Token')

  # Find our designated script container and require its source.
  #
  #     script(type='text/javascript', data-src='myfile')
  #
  window.app.requirejs [$('#script').data('src')]