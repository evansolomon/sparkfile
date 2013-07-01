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

spark.command('edit')
  .description('Open your Sparkfile in your default editor')
  .action(commands.edit)

spark.command('view [days]')
  .description('View your notes in the last [days] days')
  .action(commands.view)

module.exports.run = (argv) ->
  parsed = spark.parse argv
  spark.outputHelp() unless parsed.args.length
  parsed
