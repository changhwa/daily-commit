Api = require("github");

github = new Api(
  version: '3.0.0'
  debug: true
  protocol: 'https'
  host: 'api.github.com'
  pathPrefix: ''
  timeout: 5000
  headers: 'user-agent': 'My-Cool-GitHub-App')

class GithubApi

  constructor: () ->

  getAuth = (token) ->
    return github.authenticate(
      type: "oauth",
      token: token
    )

  getRepositoriesByUser: (param, cb) ->
    github.repos.getFromUser param, (err, res) ->
      return cb(res)

  getRepository: (param, cb) ->
    github.repos.get param, (err, res) ->
      return cb(res)

  getRepositoryCommits: (model, cb) ->
    github.repos.getCommits model, (err, res) ->
      return cb(res)

  createRepositoryHook: (token, model, cb) ->

    getAuth(token)

    github.repos.createHook model, (err, res) ->
      return cb(res)

  getRepositoryHooks: (token, model, cb) ->

    getAuth(token)

    github.repos.getHooks model, (err, res) ->
      return cb(res)

  testRepositoryHook: (token, model, cb) ->

    getAuth(token)

    github.repos.testHook model, (err, res) ->
      return cb(res)

  getRepositoryLanguage: (param, cb) ->

    github.repos.getLanguages param, (err, res) ->
      return cb(res)

module.exports = GithubApi