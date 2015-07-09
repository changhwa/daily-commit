'use strict'

models = require '../../src/model'
commitModel = models.commitModel

describe "commit model test", () ->

  it "should be can find all commit", (done) ->

    commitModel.findAll(where: { commit_author: 'changhwa', commit_date: {$between: ['2015-06-30', '2015-07-08']} } , attributes: [
      [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10), 'date'],
      [commitModel.sequelize.fn('count', commitModel.sequelize.col('commit_date')), 'cnt']
    ], group: [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10)]).then (_result) ->
      #console.log _result
      for data in _result
        console.log data.dataValues
      done()