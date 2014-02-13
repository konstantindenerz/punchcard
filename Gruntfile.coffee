module.exports = (grunt) ->

	
	require('load-grunt-tasks')(grunt);
	
	grunt.initConfig {
		pkg: grunt.file.readJSON('package.json'),
		
		yeoman: {
	      app: 'app',
	      dist: 'dist'
	    },


		'bower-install': {
	      app: {
	        html: '<%= yeoman.app %>/index.html',
	        ignorePath: '<%= yeoman.app %>/'
	      }
	    },
		clean: {
	      dist: {
	        files: [{
	          dot: true,
	          src: [
	            '.tmp',
	            '<%= yeoman.dist %>/*',
	            '!<%= yeoman.dist %>/.git*'
	          ]
	        }]
	      },
	      server: '.tmp'
	    },

		"git-rev-parse": {
		  build: {
		    options: {
		      prop: 'git-revision',
		      number: 40
		    }
		  }
		},
		watch: {
	      js: {
	        files: ['<%= yeoman.app %>/scripts/{,*/}*.coffee'],
	        tasks: ['coffee'],
	        options: {
	          livereload: true
	        }
	      },
	      jsTest: {
	        files: ['test/spec/{,*/}*.js'],
	        tasks: ['newer:jshint:test', 'karma']
	      },
	      styles: {
	        files: ['<%= yeoman.app %>/styles/{,*/}*.css'],
	        tasks: ['newer:copy:styles', 'autoprefixer']
	      },
	      gruntfile: {
	        files: ['Gruntfile.coffee']
	      },
	      livereload: {
	        options: {
	          livereload: '<%= connect.options.livereload %>'
	        },
	        files: [
	          '<%= yeoman.app %>/{,*/}*.html',
	          '.tmp/styles/{,*/}*.css',
	          '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
	        ]
	      }
	    },

		connect: {
	      options: {
	        port: 9000,
	        hostname: 'localhost',
	        livereload: true
	      },
	      livereload: {
	        options: {
	          open: true,
	          base: [
	            '.tmp',
	            '<%= yeoman.app %>'
	          ]
	        }
	      },
	      test: {
	        options: {
	          port: 9001,
	          base: [
	            '.tmp',
	            'test',
	            '<%= yeoman.app %>'
	          ]
	        }
	      },
	      dist: {
	        options: {
	          base: '<%= yeoman.dist %>'
	        }
	      }
	    },

		coffee: {
			compile: {
				files: {
					'app/scripts/punchcard.js' : ['app/scripts/*.coffee']
				}
			}
		},
		concat: {
		  options: {
		    separator: ';'
		  },
		  dist: {
		    src: ['<%= yeoman.app %>/scripts/**/*.js'],
		    dest: '<%= yeoman.dist %>/scripts/<%= pkg.name %>.js'
		  }
		}
		uglify:{
		  options: {
		    banner: '/**\n<%= pkg.name %>\nversion: <%= pkg.version %>' +
		    '\nrevision: <%= grunt.config.get("git-revision") %>\n'+
		    '<%= grunt.template.today("dd-mm-yyyy")%>\nlicense: <%= pkg.license %>\n'+
		    'author: <%= pkg.author %>\n<%= pkg.description %>\n*/\n'
		  },
		  dist: {
		    files: {
		      '<%= yeoman.dist %>/scripts/<%= pkg.name %>-<%= pkg.version %>.min.js': ['<%= concat.dist.dest %>']
		    }
		  }
		},

		concurrent: {
	      server: [
	        'copy:styles'
	      ],
	      test: [
	        'copy:styles'
	      ],
	      dist: [
	        'copy:styles',
	        'imagemin',
	        'svgmin'
	      ]
	    },

	    copy: {
	      dist: {
	        files: [{
	          expand: true,
	          dot: true,
	          cwd: '<%= yeoman.app %>',
	          dest: '<%= yeoman.dist %>',
	          src: [
	            '*.{ico,png,txt}',
	            '.htaccess',
	            '*.html',
	            'views/{,*/}*.html',
	            'bower_components/**/*',
	            'images/{,*/}*.{webp}',
	            'fonts/*'
	          ]
	        }, {
	          expand: true,
	          cwd: '.tmp/images',
	          dest: '<%= yeoman.dist %>/images',
	          src: ['generated/*']
	        }]
	      },
	      styles: {
	        expand: true,
	        cwd: '<%= yeoman.app %>/styles',
	        dest: '.tmp/styles/',
	        src: '{,*/}*.css'
	      }
	    },
	    autoprefixer: {
	      options: {
	        browsers: ['last 1 version']
	      },
	      dist: {
	        files: [{
	          expand: true,
	          cwd: '.tmp/styles/',
	          src: '{,*/}*.css',
	          dest: '.tmp/styles/'
	        }]
	      }
	    },
	    
	    rev: {
	      dist: {
	        files: {
	          src: [
	            '<%= yeoman.dist %>/scripts/{,*/}*.js',
	            '<%= yeoman.dist %>/styles/{,*/}*.css',
	            '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
	            '<%= yeoman.dist %>/styles/fonts/*'
	          ]
	        }
	      }
	    },

	    
	    useminPrepare: {
	      html: '<%= yeoman.app %>/index.html',
	      options: {
	        dest: '<%= yeoman.dist %>'
	      }
	    },

	    usemin: {
	      html: ['<%= yeoman.dist %>/{,*/}*.html'],
	      css: ['<%= yeoman.dist %>/styles/{,*/}*.css'],
	      options: {
	        assetsDirs: ['<%= yeoman.dist %>']
	      }
	    },

	    imagemin: {
	      dist: {
	        files: [{
	          expand: true,
	          cwd: '<%= yeoman.app %>/images',
	          src: '{,*/}*.{png,jpg,jpeg,gif}',
	          dest: '<%= yeoman.dist %>/images'
	        }]
	      }
	    },
	    svgmin: {
	      dist: {
	        files: [{
	          expand: true,
	          cwd: '<%= yeoman.app %>/images',
	          src: '{,*/}*.svg',
	          dest: '<%= yeoman.dist %>/images'
	        }]
	      }
	    },
	    htmlmin: {
	      dist: {
	        options: {
	          collapseWhitespace: true,
	          collapseBooleanAttributes: true,
	          removeCommentsFromCDATA: true,
	          removeOptionalTags: true
	        },
	        files: [{
	          expand: true,
	          cwd: '<%= yeoman.dist %>',
	          src: ['*.html', 'views/{,*/}*.html'],
	          dest: '<%= yeoman.dist %>'
	        }]
	      }
	    },
	}


	grunt.registerTask 'serve', ['clean:server', 'coffee', 'bower-install', 'concurrent:server', 'autoprefixer', 'connect:livereload', 'watch']

	grunt.registerTask 'build', [
		'coffee',
	    'clean:dist',
	    'bower-install',
	    'useminPrepare',
	    'concurrent:dist',
	    'autoprefixer',
	    'concat',
	    'copy:dist',
	    'uglify',
	    'rev',
	    'usemin',
	    'htmlmin'
	  ]

	

	grunt.registerTask 'default', ['coffee', 'concat', 'git-rev-parse', 'uglify', 'watch']