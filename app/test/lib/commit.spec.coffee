'use strict'

models = require '../../src/model'
commitModel = models.commitModel

statistic = require '../../src/lib/statistic'
Statistic = new statistic

describe "commit model test", () ->

  it.skip "should be can get commit count by user and current month", (done) ->
    param = {}
    param.user = "changhwa"
    Statistic.getCommitCntByUserAndMonth param, (_result) ->
      _result.length.should.be.greaterThan(0)
      for data in _result
        console.log data.dataValues
      done()