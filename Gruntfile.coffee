module.exports = (grunt) ->
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-git-rev-parse'

	grunt.initConfig {
		pkg: grunt.file.readJSON('package.json'),
		"git-rev-parse": {
		  build: {
		    options: {
		      prop: 'git-revision',
		      number: 40
		    }
		  }
		},
		coffee: {
			compile: {
				files: {
					'app/js/result.js' : ['js/*.coffee']
				}
			}
		},
		concat: {
		  options: {
		    separator: ';'
		  },
		  dist: {
		    src: ['js/**/*.js'],
		    dest: 'dist/<%= pkg.name %>.js'
		  }
		}
		uglify:{
		  options: {
		    banner: '###\n<%= pkg.name %>\nversion: <%= pkg.version %>' +
		    '\nrevision: <%= grunt.config.get("git-revision") %>\n'+
		    '<%= grunt.template.today("dd-mm-yyyy")%>\nlicense: <%= pkg.license %>\n'+
		    'author: <%= pkg.author %>\n<%= pkg.description %>\n###\n'
		  },
		  dist: {
		    files: {
		      'dist/<%= pkg.name %>-<%= pkg.version %>.min.js': ['<%= concat.dist.dest %>']
		    }
		  }
		}	

	}

	grunt.registerTask 'default', ['coffee', 'concat', 'git-rev-parse', 'uglify']