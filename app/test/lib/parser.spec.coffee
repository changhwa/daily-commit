'use strict'

githubApi = require '../../src/lib/githubApi'
GitHubApi = new githubApi
parser = require("../../src/lib/parser")
Parser = new parser

describe "github api parser test", () ->

  it.skip "should be can github commit parse", (done) ->

    param = {}
    param.user = "changhwa"
    param.repo = "geek_note"
    param.per_page = 3

    GitHubApi.getRepositoryCommits param, (_result) ->
      Parser.parseCommit param.repo, _result, (commitModel) ->
        console.log commitModel
        done()