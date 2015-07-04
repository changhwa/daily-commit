express = require 'express'
router = express.Router()
moment = require('moment');
githubApi = require '../lib/githubApi'
GitHubApi = new githubApi
parser = require '../lib/parser'
Parser = new parser
models = require '../model'
commitModel = models.commitModel
repositoryModel = models.repositoryModel

router.get "/api/:user/:repo", (req, res) ->

  param = req.params
  param.author = req.params.user
  param.per_page = 100 # 최근 100개의 커밋부터 수집시작

  repository_name = req.params.user+"/"+req.params.repo
  accessToken = req.session.passport.user.accessToken

  repositoryModel.find(where: repository_name: repository_name, user_access_token: accessToken).then (repo) ->
    GitHubApi.getRepositoryCommits param, (_result) ->
      Parser.parseCommit repo.dataValues.repository_id, _result, (commitModels) ->
        commitModel.bulkCreate(commitModels).then ->
          console.log 'success'
        repositoryModel.find(where: repository_id: commitModels[0].repository_id, user_access_token: accessToken).then (repo) ->
          repo.updateAttributes(last_commit_date: commitModels[0].commit_date).then ->
            console.log 'repo update'

router.get "/api/:user/:repo/count", (req, res) ->

  commitModel.count(where: [req.parms]).then (_result) ->
    console.log _result
    res.send _result+""


module.exports = router