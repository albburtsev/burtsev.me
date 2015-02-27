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
			options:
				sourceMap: true
			build:
				files:
					#'<%= buildPath %>bm.min.js': '<%= buildPath %>bm.js'
					'<%= buildPath %>build.js': [
						'bower_components/jquery/dist/jquery.js'
						'bower_components/director/build/director.js'
						'<%= buildPath %>bm.js'
					]
			build_ie:
				files:
					'<%= buildPath %>build.ie.js': [
						'bower_components/html5shiv/dist/html5shiv.js'
			 			'bower_components/jquery-legacy/jquery.js'
						'<%= buildPath %>bm.js'
					]

		imagemin:
			screenshots:
				files: [{
					expand: true
					cwd: 'src/static/i/screenshots/'
					src: ['*.png']
					dest: '<%= buildPath %>i/screenshots/'
				}]
			patterns:
				files: [
						expand: true
						cwd: 'src/static/i/patterns/'
						src: ['*.png']
						dest: '<%= buildPath %>i/patterns/'
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
				tasks: ['coffee', 'uglify', 'shell:docpad', 'notify:build_ready']
			docpad:
				files: [
					'docpad.coffee'
					'src/render/**/*.*'
					'src/layouts/**/*.*'
				]
				tasks: ['shell:docpad', 'notify:build_ready']

	grunt.registerTask 'default', ['stylus', 'pixrem', 'coffee', 'uglify', 'fingerprint', 'shell:docpad', 'watch']
	grunt.registerTask 'deploy', ['stylus', 'pixrem', 'coffee', 'uglify', 'fingerprint']
	grunt.registerTask 'raster', ['imagemin', 'notify:imagemin']
