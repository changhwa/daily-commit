express = require 'express'
router = express.Router()
moment = require 'moment'

statistic = require '../lib/statistic'
Statistic = new statistic

router.get '/commit/month', (req, res, next) ->
  param = {}
  param.user = req.session.passport.user.profile.login
  result = {}
  Statistic.getCommitCntByUserAndMonth param, (_result) ->
    for data in _result
      result[moment(data.dataValues.date).unix()] = data.dataValues.cnt
    console.log result
    res.send result

module.exports = router
