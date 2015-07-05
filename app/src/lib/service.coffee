githubApi = require './githubApi'
GitHubApi = new githubApi
parser = require './parser'
Parser = new parser
models = require '../model'
commitModel = models.commitModel
repositoryModel = models.repositoryModel

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

module.exports = Service