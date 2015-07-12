express = require 'express'
router = express.Router()
models = require '../model'
repositoryModel = models.repositoryModel
githubApi = require '../lib/githubApi'
GitHubApi = new githubApi

# GET home page.
router.get '/', (req, res, next) ->
  console.log req.session
  res.render 'index',
    title: 'Express'
    user: req.session.passport.user

router.get '/setup', (req, res, next) ->
  res.render 'setup',
    page: title: 'Setup'
    user: req.session.passport.user

router.get '/setup/api/repositories', (req, res, next) ->
  param = {}
  param.user = req.session.passport.user.profile.login
  param.per_page = 100

  repositoryModel.findAll(where: user_access_token: req.session.passport.user.accessToken).then (_dbResult) ->
    GitHubApi.getRepositoriesByUser param, (_apiResult) ->
      if _dbResult.length > 0
        for api in _apiResult
          for db in _dbResult
            if (api.id == db.repository_id)
              api.isSelect = true
              break
            else
              api.isSelect = false
      res.send repositories: _apiResult

router.post '/setup/api/repositories', (req, res, next) ->
  param = req.body
  param.user_access_token = req.session.passport.user.accessToken
  repositoryModel.build(param).save().then ->
    res.sendStatus(200)

router.delete '/setup/api/repositories', (req, res, next) ->
  param = req.body
  param.user_access_token = req.session.passport.user.accessToken

  repositoryModel.find(where: param).then (_result) ->
    repositoryModel.destroy(where: _result.dataValues).then (_deleteResult) ->
      console.log(_deleteResult)

module.exports = router
