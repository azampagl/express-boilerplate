#
# Main execution file for unit tests.
#
#
# *(c) 2012 Aaron Zampaglione <azampagl@azampagl.com>*
#
chai = require('chai')
fs = require('fs')
path = require('path')

# Create a new instance of mocha (BDD by default).
mocha = new (require('mocha'))

# Export Chai globally to our tests.
assert = chai.assert
should = chai.should()
expect = chai.expect

# Turn off global leaks for requirejsVars.
mocha.globals(['requirejsVars']);

#tests = [path.resolve(__dirname + '/test')]
#while tests.length
#  test = tests.pop()
#
#  # Continue if directory.
#  if fs.statSync(test).isDirectory()
#    tests = tests.concat(fs.readdirSync(test).map((file) -> path.resolve(test + '/' + file)))
#    continue
#
#  ((test) ->
#    mocha.addFile(test)
#  )(test)
mocha.addFile('test/app')
mocha.addFile('test/routes/foo')
mocha.run()