Mocha = require 'mocha'

module.exports = (grunt) ->
  # Helpers
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Config
  grunt.initConfig
    mocha:
      default:
        src: ['test/*.coffee']

    coffee:
      default:
        files: [
          expand: true         # Enable dynamic expansion.
          cwd: 'src/'          # Src matches are relative to this path.
          src: ['**/*.coffee'] # Actual pattern(s) to match.
          dest: 'lib/'         # Destination path prefix.
          ext: '.js'           # Dest filepaths will have this extension.
        ]

    watch:
      src:
        files: ['src/**/*.coffee']
        tasks: ['coffee', 'test']

      test:
        files: ['test/**/*.coffee']
        tasks: ['test']


  # Tasks
  grunt.registerTask 'default', ['coffee', 'test']
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
