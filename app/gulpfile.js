"use strict";

var gulp = require('gulp');
var coffee = require('gulp-coffee');
var debug = require('gulp-debug');

gulp.task('coffee-lint', function(){
	
	var coffeelint = require('gulp-coffeelint');
	
	return gulp.src(['./app.coffee','./src/routes/*.coffee','./public/coffeescript/**/*.coffee'])
		.pipe(coffeelint())
		.pipe(coffeelint.reporter('coffeelint-stylish'));
});

gulp.task('coffee', function(){
	return gulp.src(['./public/coffeescript/*.coffee','./public/coffeescript/**/*.coffee'])
    .pipe(coffee({bare: true}))
 		.pipe(gulp.dest('./public/javascripts'));
});

gulp.task('less', function(){

  var less = require('gulp-less');

  return gulp.src('./public/less/*.less')
    .pipe(less())
    .pipe(gulp.dest('./public/stylesheets'));
});

gulp.task('jshint',['coffee'], function(){

	var jshint = require('gulp-jshint');

	return gulp.src(['./public/javascripts/*.js','./public/javascripts/**/*.js'])
    .pipe(jshint())
    .pipe(jshint.reporter('jshint-stylish'));
});

gulp.task('server',['coffee'], function(){
  
  var nodemon = require('gulp-nodemon');
  
  return nodemon({
    script: './bin/www.coffee',
    ext: 'hbs coffee less'
  }).on('restart',['jshint','less'], function(){
		console.log ( 'Restarted!');
	});
});

gulp.task('test', function(){
  var mocha = require('gulp-mocha');
  require('coffee-script/register');
  return gulp.src('./test/**/*.coffee')
    .pipe(debug())
    .pipe(mocha({
      ui: 'bdd',
      reporter: 'spec',
      globals: {
        should: require('should')
      }
    }));
});

gulp.task('build',['coffee-lint','jshint','less']);
gulp.task('default',['server']);
