require 'coffee-script'

fs     = require 'fs'
path   = require 'path'
exec   = require('child_process').exec
should = require 'should'

utils = require '../src/utils'

describe 'Number padding', ->
  it 'Should return strings', ->
    utils.padNumber(123).should.be.a 'string'

  it 'Should pad short numbers', ->
    utils.padNumber(1).should.equal '01'

  it 'Should preserve long numbers', ->
    utils.padNumber(100).should.equal '100'

describe 'Has date', ->
  it 'Should find date markers', ->
    testString = """
      Some stuff
      Here's a date string
      [#{utils.ymd()}]

    """
    utils.hasDate(testString).should.be.true

  it 'Should ignore the date otherwise', ->
    testString = """
      Some stuff
      Here's a date
      but not as a marker
      #{utils.ymd()}
    """
    utils.hasDate(testString).should.be.false

  it 'Should ignore date markers in the middle of lines', ->
    testString = """
      Some stuff
      Here's a date marker mid-line [#{utils.ymd()}]
      let's ignore it
    """
    utils.hasDate(testString).should.be.false

describe 'Resolve location', ->
  it 'Should resolve tildes', ->
    realPath = "#{process.env.HOME}/foo"
    utils.resolveLocation('~/foo').should.equal realPath

  it 'Should resolve relative paths', ->
    utils.resolveLocation('./some/path').should.equal path.resolve('./some/path')
    utils.resolveLocation('../some/path').should.equal path.resolve('../some/path')

describe 'Append line', ->
  tempPath = 'test/tmp'
  fileName = 'Sparkfile'

  before (done) ->
    exec 'mkdir -p test/tmp && rm -rf test/tmp/*', ->
      done()

  after (done) ->
    exec 'rm -rf test/tmp/', ->
      done()

  it 'Should automatically create files', ->
    utils.appendLine "#{tempPath}/#{fileName}", 'Example note'
    fs.readdirSync(tempPath).should.include fileName

  it 'Should add lines', ->
    fs.readFileSync("#{tempPath}/#{fileName}", 'utf-8').should.equal 'Example note\n'

  it 'Should append more lines', ->
    utils.appendLine "#{tempPath}/#{fileName}", 'One more line'
    fs.readFileSync("#{tempPath}/#{fileName}", 'utf-8').should.equal """
      Example note
      One more line

    """
