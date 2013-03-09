module.exports = (app) ->	
  app.put  {path:'/api/users',   version: '1.0.0' },   app.UserController.createAccount
  app.post {path:'/api/login',   version: '1.0.0' },   app.UserController.login

  app.put  {path:'/api/matches', version: '1.0.0' },   app.LadderController.addMatch
  app.get  {path:'/api/ladder',  version: '1.0.0' },   app.LadderController.getTable