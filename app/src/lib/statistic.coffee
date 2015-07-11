
class Statistic

  getCommitCntByUser: (param, cb) ->
    commitModel.findAll(where: { commit_author: param.user, commit_date: {$between: ['2015-06-30', '2015-07-08']} } , attributes: [
      [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10), 'date'],
      [commitModel.sequelize.fn('count', commitModel.sequelize.col('commit_date')), 'cnt']
    ], group: [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10)]).then (_result) ->

      cb(_result)