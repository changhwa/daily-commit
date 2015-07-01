express = require 'express'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
session = require 'express-session'
passport = require 'passport'
GithubStrategy = require('passport-github').Strategy

routes = require './src/routes/index'
users = require './src/routes/users'

app = express()
app.use(require('connect-livereload')()) # 나중에 개발모드  / 운영모드 분리해야함

# view engine setup
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'hbs'

# uncomment after placing your favicon in /public
# app.use favicon "#{__dirname}/public/favicon.ico"
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: false
app.use cookieParser()
app.use session(
  secret: 'daily-commit'
  resave: false
  saveUninitialized: true
)
app.use require('less-middleware') path.join __dirname, 'public'
app.use express.static path.join __dirname, 'public'
app.use passport.initialize()
app.use passport.session()

getConfig = ->
  return (
    clientID: '4ca7bf161f54ef2e2b71'
    clientSecret: 'fa708357533b1a871f5bc617e0de848924200b57'
    callbackURL: 'http://localhost:3000/auth/github/callback'
  )

passport.use new GithubStrategy getConfig(), (accessToken, refreshToken, profile, done) ->
  user = profile._json
  return done(null, {accessToken, refreshToken, profile:user})

passport.serializeUser (user, done) ->
  done(null, user)

passport.deserializeUser (obj, done) ->
  done(null, obj)

app.use '/', routes
app.use '/users', users

app.get '/auth/github', passport.authenticate('github')
app.get '/auth/github/callback', passport.authenticate('github', {failureRedirect:"/?login-error",successRedirect:"/"})
app.get '/logout', (req, res)->
  req.logout()
  res.redirect('/')

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

# error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message,
      error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message,
    error: {}

module.exports = app
