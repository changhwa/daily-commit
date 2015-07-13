'use strict'

Api = require("../../src/lib/githubApi")
GitHubApi = new Api

describe "github api test", () ->

  OK = "200 OK"

  it.skip 'should be get github repository', (done) ->
    param = {}
    param.user = "changhwa"
    param.repo = "geek_note"
    GitHubApi.getRepository param, (_result) ->
      _result.meta.status.should.be.eql "200 OK"
      done()

  it.skip 'should be get repository commit list', (done) ->
    param = {}
    param.user = "changhwa"
    param.repo = "geek_note"
    param.per_page = 500
    GitHubApi.getRepositoryCommits param, (_result) ->
      console.log _result.length
      done()

  it.skip 'should be get repositories by user', (done) ->
    param = {}
    param.user = "changhwa"
    param.per_page = "10"
    GitHubApi.getRepositoriesByUser param, (_result) ->
      console.log _result
      _result.meta.status.should.be.eql OK
      done()

  it.skip 'should be can get hooks', (done) ->
    param = {}
    param.user = "changhwa"
    param.repo = "PR-Test"
    GitHubApi.getRepositoryHooks param, (_result) ->
      console.log _result
      _result.meta.status.should.be.eql OK
      done()

  it.skip 'should be can test hook', (done) ->
    # 5238868
    param = {}
    param.user = "changhwa"
    param.repo = "PR-Test"
    param.id = 5238868
    GitHubApi.testRepositoryHook param, (_result) ->
      console.log _result
      _result.meta.status.should.be.eql OK
      done()

  it.skip 'should be get repository language', (done) ->
    param = {}
    param.user = "changhwa"
    param.repo = "daily-commit"
    GitHubApi.getRepositoryLanguage param, (_result) ->
      language = _result
      delete language.meta
      console.log JSON.stringify(language)
      done()