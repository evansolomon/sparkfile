module.exports = (grunt) ->
  # Helpers
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-simple-mocha'

  # Config
  grunt.initConfig
    watch:
      src:
        files: ['src/**/*.coffee']
        tasks: ['test']

      test:
        files: ['test/**/*.coffee']
        tasks: ['test']

    simplemocha:
      options:
        reporter: 'spec'
        compilers: 'coffee:coffee-script'
      all: {src: 'test/*'}


  # Tasks
  grunt.registerTask 'default', ['test']
  grunt.registerTask 'test', 'simplemocha'
