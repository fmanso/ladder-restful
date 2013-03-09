restify = require('restify')
assert = require('assert')

before((done) -> 
  require('../server.js')     
  done()
)