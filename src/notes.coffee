fs = require 'fs'

utils = require './utils'

module.exports =
  read: (location) ->
    try
      location = utils.resolveLocation location
      fs.readFileSync location, 'utf-8'
    catch
      ''

  write: (location, note) ->
    unless utils.hasDate @read(location)
      utils.appendLine location, "\n[#{utils.ymd()}]"

    utils.appendLine location, "- #{note}"
