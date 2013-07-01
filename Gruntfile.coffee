Mocha = require 'mocha'

module.exports = (grunt) ->
  # Helpers
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Config
  grunt.initConfig
    mocha:
      default:
        src: ['test/*.coffee']

    watch:
      src:
        files: ['src/**/*.coffee']
        tasks: ['test']

      test:
        files: ['test/**/*.coffee']
        tasks: ['test']


  # Tasks
  grunt.registerTask 'default', ['test']
  grunt.registerTask 'test', 'mocha'

  grunt.registerMultiTask 'mocha', 'Run mocha unit tests.', ->
    done = @async()

    mocha = new Mocha
      reporter: 'spec'

    for files in @files
      for file in files.src
        mocha.addFile file

    mocha.run (failures) =>
      if failures
        grunt.log.error(failures).writeln()
      done()
