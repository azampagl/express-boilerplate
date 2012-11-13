#
# Root level operations for all the unit tests.
#
# "requirejs", "request" (supertest), "async", and "app" are initialized here and can referenced in all
# unit tests as long as they are nested within:
#
#     describe "app", ->
#       it "should not be null" () =>
#         @app.should.not.equal null
# 
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#

#
# # before() #
#
# Initializes requirejs.
#
before () ->
  path = require('path')
  requirejs = require('requirejs')
  @requirejs = requirejs.config
    baseUrl: path.resolve(__dirname, '../../../../app')

#
# # beforeEach #
#
# Initializes app.
#
beforeEach (done) ->
  console.log "beforeEach"
  @requirejs ['app'], (app) =>
    # Async load the app and continue when done.
    app (app) =>
      @app = app
      done()

describe "app", ->
  #
  # # app #
  #
  # Global reference to the application.
  #
  @app = null

  #
  # # async #
  #
  # Global reference to the async library.
  #
  @async = require('async')

  #
  # # request #
  #
  # Supertest request object.
  #
  @request = require('supertest')

  #
  # # requirejs #
  #
  # Global reference to requirejs.
  #
  @requirejs = null

  #
  # # before() #
  #
  # Initializes requirejs.
  #
  #before () =>
  #  path = require('path')
  #  requirejs = require('requirejs')
  # 
  #  @requirejs = requirejs.config
  #    baseUrl: path.resolve(__dirname, '../../../../app')

  #
  # # beforeEach #
  #
  # Initializes app.
  #
  #beforeEach (done) =>
  #  console.log "beforeEach"
  #  @requirejs ['app'], (app) =>
  #    # Async load the app and continue when done.
  #    app (app) =>
  #      @app = app
  #      done()

  it "should not be null", (done) =>
    console.log this
    @app.should.not.equal null
    done()