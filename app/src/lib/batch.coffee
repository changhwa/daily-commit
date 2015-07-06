schedule = require('node-schedule')
moment = require 'moment'
models = require '../model'
commitModel = models.commitModel
repositoryModel = models.repositoryModel
userModel = models.userModel
service = require './service'
Service = new service


class Batch

  # 10분마다 저장소를 가져와서 커밋정보를 가져온다
  getCommits: () ->
    schedule.scheduleJob('*/10 * * * *', ->
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
            Service.saveCommits param, user.user_access_token, repo.repository_name, (_result) ->
              console.log(_result)
    )

module.exports = Batch