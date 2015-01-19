module.exports = (grunt) ->
	'use strict'

	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		stylus:
			styles:
				files:
					'build/styles.css': 'static/css/styles.styl'

		concat:
			styles:
				src: [
					'build/styles.css'
					'bower_components/normalize.css/normalize.css'
				]
				dest: 'build/build.css'

		notify:
			build_ready:
				options:
					message: 'Build is ready!'

		watch:
			stylus:
				files: [
					'static/css/**/*.styl'
				],
				tasks: ['stylus', 'concat:styles', 'notify:build_ready']

	grunt.registerTask 'default', ['stylus', 'concat', 'watch']
