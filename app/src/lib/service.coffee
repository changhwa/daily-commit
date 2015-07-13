moment = require 'moment'
githubApi = require './githubApi'
GitHubApi = new githubApi
parser = require './parser'
Parser = new parser
models = require '../model'
commitModel = models.commitModel
repositoryModel = models.repositoryModel
userModel = models.userModel

class Service

  saveCommits: (param, accessToken, repository_name, cb) ->
    repositoryModel.find(where: repository_name: repository_name, user_access_token: accessToken).then (repo) ->
      GitHubApi.getRepositoryCommits param, (_result) ->
        if _result.length > 0
          Parser.parseCommit repo.dataValues.id, _result, (commitModels) ->
            commitModel.bulkCreate(commitModels).then ->
              console.log 'success'
              cb('success')
            repositoryModel.find(where: id: commitModels[0].repository_id, user_access_token: accessToken).then (repo) ->
              repo.updateAttributes(last_commit_date: commitModels[0].commit_date).then ->
                console.log 'repo update'
          Service::updateLanguage repo, (update) ->
            console.log 'update'
        else
          cb('no event')

  saveCommitsByHook: (model, cb) ->
    userModel.find(where: user_id: model.sender.id).then (user) ->
      repositoryModel.find(where: repository_name: model.repository.name, user_access_token: user.dataValues.user_access_token).then (repo) ->
        Parser.parseHookCommit model, repo.dataValues.id,  (commitModels) ->
          console.log commitModels
          commitModel.bulkCreate(commitModels).then ->
            cb('success')

  updateLanguage: (repo, cb) ->
    param = {}
    param.user = repo.dataValues.repository_full_name.split('/')[0]
    param.repo = repo.dataValues.repository_name

    GitHubApi.getRepositoryLanguage param, (_result) ->
      language = _result
      delete language.meta
      repo.updateAttributes( language: JSON.stringify(language) ).then (_update) ->
        cb('success')

  sync: (model, cb) ->
    userModel.findAll( include: [ model: repositoryModel, required: true]).then (_userRepo) ->
      for user in _userRepo
        for repo in user.repositoryModels
          param = {}
          param.user = user.user_name
          param.repo = repo.repository_name
          param.per_page = 100
          param.author = user.user_name
          if repo.last_commit_date
            param.since = moment(new Date(repo.last_commit_date)).add(1, 'seconds').format()
            param.until = moment().format()
          console.log "> batch get commits param <"
          console.log param
          Service::saveCommits param, user.user_access_token, repo.repository_name, (_result) ->
            cb(_result)


module.exports = Service