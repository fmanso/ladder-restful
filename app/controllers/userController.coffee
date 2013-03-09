bcrypt = require('bcrypt')
crypto = require('crypto')


class UserController
  constructor: (@app) ->
    console.log 'AccountController Initialized'
    @userModel = new require('../models/User')(@app)

  createAccount: (req, res, next) =>    
    user = {
      'email': req.params.email, 
      'name': req.params.name, 
      'password': req.params.password
    }

    @userModel.createAccount(user, (err) =>
      if err == null
        res.send('')
        return next()
      else
        return next err
    )          

  login: (req, res, next) =>
    data =  {
      'email': req.params.email,
      'password': req.params.password
    }

    @userModel.login(data, (error, authToken) =>
      if error == null
        output = {'authToken': authToken}
        res.send output
        return next()
      else
        return next error
    )  

module.exports = (app) -> app.UserController = new UserController(app);