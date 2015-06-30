'use strict'

Api = require("../../src/lib/githubApi")
GitHubApi = new Api

describe "github api test", () ->
  it 'should be get github repository', (done) ->
    param = {}
    param.user = "changhwa"
    param.repo = "geek_note"
    GitHubApi.getRepository param, (_result) ->
      _result.meta.status.should.be.eql "200 OK"
      done()
