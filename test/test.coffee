restify = require('restify')
mongojs = require('mongojs')

databaseUrl = process.env.MONGO_URL || 'mongodb://localhost/LadderRest'

class Test
  @client = restify.createJsonClient({
    version: '*',
    url: 'http://localhost:3000'
  })

  @db = mongojs.connect(databaseUrl, ['users'])

module.exports = Test