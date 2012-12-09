fs            = require 'fs'
{print}       = require 'util'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

# Node command.
nodeCommand = 'node'

# Coffee command.
cmdCoffee = './coffee'

#
# Log a message to terminal.
#
log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

#
# Compiles "./src" directory to the "./app" directory.
#
build = (callback) ->
  options = ['-c', '-b', '-o', 'app', 'src']
  coffee = spawn cmdCoffee, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> callback?() if status is 0

task 'build', 'Build src directory.', ->
  build -> log "Success", green

#
# Functional tests.
#
functionalTest = (files, callback) ->
  args = [
    './app/tests/functional/run.js'
  ]

  # Append the files to the arguments.
  args = args.concat(files)

  node = spawn nodeCommand, args, []
  node.stdout.pipe process.stdout 
  node.stderr.pipe process.stderr
  node.on 'exit', (status) -> callback?() if status is 0

option '-i', '--input [FILES]', 'Test file(s) to run, seperated by commas.'
task 'functionalTest', 'Run functional tests.', (options) ->
  files = []  
  if options.input
    files = options.input.split(',')
  build -> functionalTest files, () -> log "Success", green

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