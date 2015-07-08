'use strict'

models = require '../../src/model'
commitModel = models.commitModel

describe "commit model test", () ->

  it "should be can find all commit", (done) ->

    commitModel.findAll(attributes: [
      [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10), 'date'],
      [commitModel.sequelize.fn('count', commitModel.sequelize.col('commit_date')), 'cnt']
    ], group: [commitModel.sequelize.fn('substr', commitModel.sequelize.col('commit_date'), 1, 10)]).then (_result) ->
      #console.log _result
      for data in _result
        console.log data.dataValues
      done()