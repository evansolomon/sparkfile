fs   = require 'fs'
path = require 'path'

moment = require 'moment'

module.exports =
  ymd: ->
    moment().format('YYYY-MM-DD')

  hasDate: (sparkContent) ->
    dateString = "\n[#{@ymd()}]\n"
    sparkContent.indexOf(dateString) > -1

  resolveLocation: (location) ->
    if location.substr(0, 2) is '~/'
      location = "#{process.env.HOME}/#{location.slice(2)}"

    path.resolve location

  appendLine: (location, note) ->
    location = @resolveLocation location
    fs.appendFileSync location, "#{note}\n"
