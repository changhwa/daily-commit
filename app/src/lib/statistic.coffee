moment = require 'moment'
models = require '../model'
commitModel = models.commitModel

class Statistic

  getCommitCntByUserAndMonth: (param, cb) ->

    currentMonth = moment().format("YYYY-MM")
    startDay = moment(currentMonth+"-"+"01"+" 00:00:00")
    endDay = startDay.clone().endOf('month')

    commitModel.findAll(where: { commit_author: param.user, commit_date: {$between: [startDay.toDate(), endDay.toDate()]} } , attributes: [
      [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10), 'date'],
      [commitModel.sequelize.fn('count', commitModel.sequelize.col('commit_date')), 'cnt']
    ], group: [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10)]).then (_result) ->
      cb(_result)

module.exports = Statistic