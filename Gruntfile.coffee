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
					'build/bm.js': [
						'static/js/src/*.coffee'
					]

		uglify:
			ui:
				files:
					'build/bm.min.js': 'build/bm.js'

		concat:
			build:
				options:
					separator: ';'
				src: [
					'bower_components/jquery/dist/jquery.min.js'
					'bower_components/director/build/director.min.js'
					'build/bm.min.js'
				]
				dest: 'build/build.js'

		notify:
			build_ready:
				options:
					message: 'Build is ready!'

		watch:
			styles:
				files: [
					'static/css/**/*.styl'
				],
				tasks: ['stylus', 'notify:build_ready']
			scripts:
				files: [
					'static/js/**/*.coffee'
				],
				tasks: ['coffee', 'uglify', 'concat', 'notify:build_ready']

	grunt.registerTask 'default', ['stylus', 'coffee', 'uglify', 'concat', 'watch']
	grunt.registerTask 'deploy', ['stylus', 'coffee', 'uglify', 'concat']
