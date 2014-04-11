module.exports = (grunt) ->
	urlRewrite = require 'grunt-connect-rewrite'
	config =
		pkg: '<json:package.json>'

		connect:
			server:
				options:
					middleware: (connect, options)->
						[
							(req, res, next)->
								res.setHeader('Access-Control-Allow-Origin', '*')
								res.setHeader('Access-Control-Allow-Methods', '*')
								next()
								return
							connect.static(options.base) # position important!!
						]
					hostname: "*"
					port: 8000
					base: "./tests/"


		# the watch task
		# compile on file change
		watch:
			options:
				livereload: true
				spawn: false

			coffee:
				files: ['./src/*.coffee']
				tasks: ['coffee:compile']

		coffee:
			compile:
				files:[{
					expand: true
					cwd: './src/'
					src: ['*.coffee']
					dest: './dist/'
					ext: '.js'
				},{
					expand: true
					cwd: './src/'
					src: ['*.coffee']
					dest: './tests/'
					ext: '.js'
				}]
		mocha:
			test:
				src: ['dist/*.html']
				options:
					timeout: 10000

	# init the Project configuration
	# from above
	grunt.initConfig config

	# load all needed tasks
	# install them via "npm install"
	# in the directory root
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-mocha'

	# Default task:
	# run all above configured tasks
	# in this order when the user calls "grunt" in the project root
	grunt.registerTask 'dev', ["connect","watch"]
	grunt.registerTask 'default', [
		"coffee:compile"
	]