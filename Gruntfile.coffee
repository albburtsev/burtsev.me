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
			coffee:
				files: [
					'static/js/**/*.coffee'
				],
				tasks: ['coffee', 'notify:build_ready']

	grunt.registerTask 'default', ['stylus', 'coffee', 'watch']
