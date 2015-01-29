module.exports = (grunt) ->
	'use strict'

	require('load-grunt-tasks')(grunt)
	require('time-grunt')(grunt)

	grunt.initConfig
		stylus:
			styles:
				options:
					urlfunc: 'embedurl'
					paths: [
						'bower_components/normalize.styl/'
					]
				files:
					'build/build.css': 'static/css/styles.styl'

		coffee:
			compile:
				files:
					'build/build.js': [
						'static/js/src/footer.coffee'
					]

		uglify:
			ui:
				files:
					'build/build.min.js': 'build/build.js'

		notify:
			build_ready:
				options:
					message: 'Build is ready!'

		watch:
			stylus:
				files: [
					'static/css/**/*.styl'
				],
				tasks: ['stylus', 'notify:build_ready']
			ui:
				files: [
					'static/js/**/*.coffee'
				],
				tasks: ['coffee', 'uglify', 'notify:build_ready']

	grunt.registerTask 'default', ['stylus', 'coffee', 'uglify', 'watch']
	grunt.registerTask 'deploy', ['stylus', 'coffee', 'uglify']
