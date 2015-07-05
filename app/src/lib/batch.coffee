schedule = require('node-schedule')
models = require '../model'
commitModel = models.commitModel
repositoryModel = models.repositoryModel

class Batch

  getCommits: () ->
    schedule.scheduleJob('*/1 * * * *', ->
      repositoryModel.findAll().then (_repo) ->

    )

module.exports = Batch