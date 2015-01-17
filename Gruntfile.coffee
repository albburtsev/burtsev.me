module.exports = (grunt) ->
	'use strict'

	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		concat:
			styles:
				src: ['bower_components/normalize.css/normalize.css']
				dest: 'build/styles.css'

	grunt.registerTask 'default', ['concat']