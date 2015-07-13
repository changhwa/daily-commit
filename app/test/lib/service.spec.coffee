'use strict'

service = require '../../src/lib/service'
service = new service

describe "service test", () ->

  it "should be can sync", (done) ->

    @timeout 10000

    service.sync {}, (_result) ->
      console.log _result
      done()