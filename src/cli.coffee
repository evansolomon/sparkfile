fs    = require 'fs'
path  = require 'path'
spark = require 'commander'

commands = require './commands'

# Load our options and parse the command
spark.option('--location <path>', 'choose a file location [~/.sparkfile]', String, '~/.sparkfile')
spark.version require('../package.json').version

spark.command('*')
  .description('Your latest thought... [--location LOCATION] ')
  .action(commands.add)

module.exports.run = (argv) ->
  spark.parse argv
