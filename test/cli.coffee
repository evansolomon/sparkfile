fs     = require 'fs'
path   = require 'path'
exec   = require('child_process').exec
should = require 'should'

utils = require '../lib/utils'

# We have to wait to load this until process.argv is overwritten
cli = require '../lib/cli'

testFile = 'test/tmp/Sparkfile'
testDir  = path.dirname testFile
shimArgs = null
cliResult = null

describe 'Command line interface', ->
  before (done) ->
    command = "--location #{testFile} Some note message"
    shimArgs = process.argv[0..1]
    shimArgs = shimArgs.concat command.split(' ')

    exec "mkdir -p #{testDir} && rm -rf #{testDir}/*", ->
      cliResult = cli.run shimArgs
      done()

  after (done) ->
    exec "rm -rf #{testDir}", ->
      done()

  it 'Should parse version number', ->
    cliResult._version.should.equal require('../package.json').version

  it 'Should parse location', ->
    cliResult.location.should.equal testFile

  it 'Should write a note', ->
    fs.existsSync(testFile).should.be.ok

  it 'Should have the correct note contents', ->
    contents = fs.readFileSync testFile, 'utf-8'
    contents.trim().should.equal """
      [#{utils.ymd()}]
      - Some note message
    """
