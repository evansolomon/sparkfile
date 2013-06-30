fs   = require 'fs'
path = require 'path'

module.exports =
  padNumber: (number) ->
    number = number.toString()
    number = "0#{number}" while number.length < 2
    number

  ymd: ->
    date = new Date
    yearMonthDay = [date.getFullYear(), date.getMonth() + 1, date.getDate()]
    yearMonthDay.map(@padNumber).join '-'

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
