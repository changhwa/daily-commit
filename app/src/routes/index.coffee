express = require 'express'
router = express.Router()

# GET home page.
router.get '/', (req, res, next) ->
  console.log req.session
  res.render 'index',
    title: 'Express'
    user: req.session.passport.user

module.exports = router
