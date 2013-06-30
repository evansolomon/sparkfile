fs     = require 'fs'
path   = require 'path'
exec   = require('child_process').exec
should = require 'should'

utils = require '../lib/utils'

# Cache the original ARGV so we can overwrite it
_argv = process.argv

# We have to wait to load this until process.argv is overwritten
cli = null

testFile = 'test/tmp/Sparkfile'
testDir  = path.dirname testFile

describe 'Command line interface', ->
  before (done) ->
    command = "--location #{testFile} Some note message"

    process.argv = process.argv.slice 0, 2
    process.argv = process.argv.concat command.split(' ')

    # Now that process.argv is ready, load the module
    cli = require '../lib/cli'


    exec "mkdir -p #{testDir} && rm -rf #{testDir}/*", ->
      done()

  after (done) ->
    # Reset process.argv
    process.argv = _argv

    exec "rm -rf #{testDir}", ->
      done()

  it 'Should parse version number', ->
    cli.app._version.should.equal require('../package.json').version

  it 'Should parse location', ->
    cli.app.location.should.equal testFile

  it 'Should parse the note body', ->
    cli.app.note.should.equal 'Some note message'

  it 'Should write a note', ->
    cli.run()
    contents = fs.readFileSync testFile, 'utf-8'
    contents.trim().should.equal """
      [#{utils.ymd()}]
      - Some note message
    """
