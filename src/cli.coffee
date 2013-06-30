fs    = require 'fs'
path  = require 'path'
spark = require 'commander'

notes = require './notes'

# Load our options and parse the command
spark.option('--location <path>', 'choose a file location [~/.sparkfile]', String, '~/.sparkfile')
spark.version require('../package.json').version
spark.usage '[option] Your latest thought...'
spark.parse process.argv

# Join non-option inputs into the note body
spark.note = spark.args.join ' '

module.exports.app = spark
module.exports.run = ->
  if spark.note
    notes.write spark.location, spark.note
  else
    spark.outputHelp()
