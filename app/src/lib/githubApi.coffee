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

  getRepository: (param, cb) ->
    github.repos.get param, (err, res) ->
      return cb(res)

  getRepositoryCommits: (model, cb) ->
    github.repos.getCommits model, (err, res) ->
      return cb(res)


module.exports = GithubApi