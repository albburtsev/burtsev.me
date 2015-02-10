module.exports = (grunt) ->
	'use strict'

	require('load-grunt-tasks')(grunt)
	require('time-grunt')(grunt)

	grunt.initConfig
		buildPath: 'src/static/build/'

		stylus:
			styles:
				options:
					urlfunc: 'embedurl'
					paths: [
						'bower_components/normalize.styl/'
					]
				files:
					'<%= buildPath %>build.css': 'src/static/css/styles.styl'

		pixrem:
			options:
				rootvalue: '25px'
			dist:
				src: '<%= buildPath %>build.css'
				dest: '<%= buildPath %>build.ie.css'

		coffee:
			compile:
				files:
					'<%= buildPath %>bm.js': [
						'src/static/js/src/*.coffee'
					]

		uglify:
			ui:
				files:
					'<%= buildPath %>bm.min.js': '<%= buildPath %>bm.js'

		concat:
			options:
				separator: '\n;'
			build:
				src: [
					'bower_components/jquery/dist/jquery.min.js'
					'bower_components/director/build/director.min.js'
					'<%= buildPath %>bm.min.js'
				]
				dest: '<%= buildPath %>build.js'

			build_ie:
				src: [
					'bower_components/html5shiv/dist/html5shiv.min.js'
					'bower_components/jquery-legacy/jquery.min.js'
					'build/bm.min.js'
				]
				dest: '<%= buildPath %>build.ie.js'

		imagemin:
			screenshots:
				files: [{
					expand: true
					cwd: 'src/static/i/screenshots/src/'
					src: ['*.png']
					dest: 'src/static/i/screenshots/'
				}]
			patterns:
				files: [
						expand: true
						cwd: 'src/static/i/patterns/src/'
						src: ['*.png']
						dest: 'src/static/i/patterns/'
				]

		notify:
			build_ready:
				options:
					message: 'Build is ready!'
			imagemin:
				options:
					message: 'All images was minified'

		shell:
			options:
				stdout: true
			docpad:
				command: [
					'rm -rf out/'
					'docpad generate --env static'
				].join '&&'

		fingerprint:
			assets:
				src: [
					'<%= buildPath %>*.*'
				]
				filename: 'fingerprint.coffee'
				template: 'exports.fp = \'<%= fingerprint %>\''

		clean: [
			'<%= buildPath %>'
		]

		watch:
			styles:
				files: [
					'src/static/css/**/*.styl'
				]
				tasks: ['stylus', 'pixrem', 'shell:docpad', 'notify:build_ready']
			scripts:
				files: [
					'src/static/js/**/*.coffee'
				]
				tasks: ['coffee', 'uglify', 'concat', 'shell:docpad', 'notify:build_ready']
			docpad:
				files: [
					'docpad.coffee'
					'src/render/**/*.*'
					'src/layouts/**/*.*'
				]
				tasks: ['shell:docpad', 'notify:build_ready']

	grunt.registerTask 'default', ['clean', 'stylus', 'pixrem', 'coffee', 'uglify', 'concat', 'fingerprint', 'shell:docpad', 'watch']
	grunt.registerTask 'deploy', ['clean', 'stylus', 'pixrem', 'coffee', 'uglify', 'concat', 'fingerprint']
	grunt.registerTask 'raster', ['imagemin', 'notify:imagemin']
