fs            = require 'fs'
{print}       = require 'util'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

# Coffee command.
cmdCoffee = './coffee'

#
# Log a message to terminal.
#
# @param string message
# @param string color
# @param string explanation
#
log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

#
# Compiles app.coffee and src directory to the app directory.
#
# @param function callback [optional]
#
build = (callback) ->
  options = ['-c','-b', '-o', 'app', 'src']
  coffee = spawn cmdCoffee, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> callback?() if status is 0

task 'build', 'Build src directory.', ->
  build -> log "Success", green

#
# Mocha tests.
#
# @param function callback [optional]
#
test = (callback) ->
  options = [
    '--compilers'
    'coffee:coffee-script'
    '--colors'
    '--require'
    'should'
    '--require'
    './server'
  ]
  try
    cmd = which.sync 'mocha' 
    spec = spawn cmd, options
    spec.stdout.pipe process.stdout 
    spec.stderr.pipe process.stderr
    spec.on 'exit', (status) -> callback?() if status is 0
  catch err
    log err.message, red
    log "Mocha is not installed - try npm install mocha -g", red

task 'test', 'Run Mocha tests.', ->
  build -> test -> log "Success", green

#
# Constantly watch coffee files while in dev.
#
task 'dev', 'Running in dev mode.', ->
  # Watch coffee.
  options = ['-c', '-b', '-w', '-o', 'app', 'src'] 
  coffee = spawn cmdCoffee, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  log "Watching coffee files", green