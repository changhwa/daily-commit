express = require 'express'
router = express.Router()
lib = require '../lib/service'
service = new lib
githubApi = require '../lib/githubApi'
GithubApi = new githubApi
models = require '../model'
commitModel = models.commitModel
repositoryModel = models.repositoryModel

router.get "/api/:user/:repo", (req, res) ->

  param = req.params
  param.author = req.params.user
  param.per_page = 100 # 최근 100개의 커밋부터 수집시작

  repository_name = req.params.repo
  accessToken = req.session.passport.user.accessToken

  service.saveCommits param, accessToken, repository_name, (_result) ->
    res.sendStatus(200)

router.get "/api/:user/:repo/count", (req, res) ->

  commitModel.count(where: [req.parms]).then (_result) ->
    console.log _result
    res.send _result+""

router.post '/api/:user/:repo/hooks', (req, res) ->
  accessToken = req.session.passport.user.accessToken
  param = req.params
  param.name = "web"
  param.config = {}
  param.config.url = "http://583dbf27.ngrok.io/repository/api/hooks/payload"
  param.config.content_type = "json"

  GithubApi.createRepositoryHook accessToken, param, (_result) ->
    res.sendStatus(200)

router.post '/api/hooks/payload', (req, res) ->
  console.log req.body
  service.saveCommitsByHook req.body, (status) ->
    res.sendStatus(200)

module.exports = router