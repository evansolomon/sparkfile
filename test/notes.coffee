require 'coffee-script'

fs     = require 'fs'
path   = require 'path'
exec   = require('child_process').exec
should = require 'should'

notes = require '../src/notes'
utils = require '../src/utils'

testFile = 'test/tmp/Sparkfile'
testDir  = path.dirname testFile

describe 'Reading notes', ->
  it 'Should return an empty string if the file does not exist', ->
    notes.read(testFile).should.equal ''

  it 'Should return the file contents when it does exist', ->
    fileData = """
      I am Jack's complete lack of surprise
    """

    fs.mkdirSync testDir
    fs.appendFileSync testFile, fileData

    notes.read(testFile).should.equal fileData

describe 'Writing notes', ->
  before (done) ->
    exec 'mkdir -p test/tmp/ && rm -rf test/tmp/*', ->
      done()

  after (done) ->
    exec 'rm -rf test/tmp', ->
      done()

  it 'Should error if the directory does not exist', ->
    (-> notes.write 'test/faketmp/Sparkfile', 'Hello world').should.throw()

  it 'Should create the file if it does not exist', ->
    fs.readdirSync(testDir).should.not.include path.basename(testFile)

    notes.write testFile, 'some note'
    fs.readdirSync(testDir).should.include path.basename(testFile)

  it 'Should create dates for the first note on a day', ->
    fs.readFileSync(testFile, 'utf-8').trim().should.equal """
      [#{utils.ymd()}]
      - some note
    """

  it 'Should add lines under the same date', ->
    notes.write testFile, 'another note'
    notes.write testFile, 'last note'

    fs.readFileSync(testFile, 'utf-8').trim().should.equal """
      [#{utils.ymd()}]
      - some note
      - another note
      - last note
    """
