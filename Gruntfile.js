(function ()  {
  'use strict';
}());
module.exports = function (grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    concat: {
      options: {
        separator: '\r\n'
      },
      dist: {
        src: ['_assets/javascripts/tooltips.js'],
        dest: '_assets/scripts.js'
      }
    },

    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      },
      dist: {
        files: {
          '_assets/scripts.min.js':  ['<%= concat.dist.dest %>']
        }
      }
    },

    jshint: {
      files: ['gruntfile.js', '_assets/javascripts/*.js', '_assets/scripts.js'],
      options: {
        globals : {
          jQuery: true,
          console: true,
          module: true
        }
      }
    },

    compass: {
      dist: {
        options: {
          sassDir: '_assets/scss',
          cssDir: '_assets/stylesheets',
          environment: 'development',
          outputStyle: 'compressed'
        }
      }
    },

    watch: {
      files: ['<%= jshint.files %>', '_assets/scss/**/*.scss'],
      tasks: ['concat', 'uglify', 'jshint', 'compass']
    }
  });

  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.registerTask('default', ['concat', 'uglify', 'jshint', 'compass', 'watch']);
};

