notes = require './notes'

module.exports =
  add: (words..., obj) ->
    notes.write obj.parent.location, words.join ' '
