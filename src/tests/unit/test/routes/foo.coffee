#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#
describe "app", ->
  #console.log this
  describe "route", =>
    #console.log this
    describe "foo", =>
      #console.log this

      #
      @baseUrl = '/foo'

      describe "GET " + @baseUrl + "/foo", =>
        it "should respond with a 200", (done) =>
          done()
          #@request(@app)
          #  .get(@baseUrl + '/foo')
          #  .expect(200, done)