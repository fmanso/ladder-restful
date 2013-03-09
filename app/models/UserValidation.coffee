JSV = require('JSV').JSV  

module.exports = (user, schema) ->
    jsonSchema = require('../schemas/UserSchemas')    
    json = JSON.stringify(user)
    env = JSV.createEnvironment()
    report = env.validate(user, jsonSchema[schema])  
    return report.errors.length == 0