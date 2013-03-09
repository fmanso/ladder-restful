JSV = require('JSV').JSV
assert = require('assert')

schema = {
  "description" : "A geographical coordinate",
  "type" : "object",
  "properties" : {
    "latitude" : { "type" : "number", "required": true},
    "longitude" : { "type" : "number", "required": true }
  }
}

env = JSV.createEnvironment()

describe('JSON Validation', () ->

    it('should validate', (done) ->
      json = {        
        "latitude": 1,
        "longitude": 2        
      }
      
      validation = env.validate(json, schema)
      assert.equal(0, validation.errors.length)
      done()      
      )

    it('should not validate', (done) ->
      
      json = {
        "latitude": 0
      }
      
      validation = env.validate(json, schema)
      assert.notEqual(0, validation.errors.length)
      done()
      )
  )