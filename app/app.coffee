# Restify Server
restify = require 'restify'
app = restify.createServer()
app.restify = restify
app.use(restify.bodyParser())

# Helpers
app.helpers = require "./autoload"

# Auto load controllers
app.helpers.autoload "#{__dirname}/../app/controllers", app

# Routes
require("./routes")(app)

# Database
mongojs = require('mongojs')
databaseUrl = process.env.MONGO_URL || 'mongodb://localhost/LadderRest'  
collections = ['users']    
app.db = mongojs.connect(databaseUrl, collections)

# Init Restify Server
port = process.env.PORT || 3000
console.log "Restify server listening on port #{port}"
app.listen port
