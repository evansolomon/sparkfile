exec = require('child_process').exec
_    = require 'lodash'

notes = require './notes'

module.exports =
  add: (words..., obj) ->
    notes.write obj.parent.location, words.join ' '

  edit: (obj) ->
    exec "open #{obj.parent.location}"

  view: (daysAgo, obj) ->
    daysAgo = parseInt daysAgo, 10
    content = notes.read obj.parent.location

    return console.log content unless daysAgo

    # Look for the first date marker after the time we want to start
    startingDate = new Date(Date.now() - (1000 * 60 * 60 * 24 * daysAgo))

    dateMarkers = content.match(/^\[[0-9]{4}-[0-9]{2}-[0-9]{2}\]$/gm)
    recentDate = _.find dateMarkers, (marker) ->
      markerDate = new Date marker.slice 1, marker.length - 1

      # Adjust date for local timezone
      markerDate = new Date +markerDate + (markerDate.getTimezoneOffset() * 60 * 1000)
      markerDate >= startingDate

    matchedNotes = content.substr(content.indexOf(recentDate)).trim()
    console.log matchedNotes || if daysAgo is 1
      "You don't have any notes in the last day"
    else
      "You don't have any notes in the last #{daysAgo} days"
