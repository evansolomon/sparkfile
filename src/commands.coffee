exec = require('child_process').exec

notes = require './notes'

module.exports =
  add: (words..., obj) ->
    notes.write obj.parent.location, words.join ' '

  edit: (obj) ->
    exec "open #{obj.parent.location}"
