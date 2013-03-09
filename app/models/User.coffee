bcrypt = require('bcrypt')
assert = require('assert')
crypto = require('crypto')
JSV = require('JSV').JSV

class User
  constructor: (@app) ->
    @validate = require('./UserValidation')

  hashPassword: (password) ->
    salt = bcrypt.genSaltSync(10)    
    hashedPassword = bcrypt.hashSync(password, salt)
    return hashedPassword

  checkPassword: (password, hashedPassword) =>    
    return bcrypt.compareSync(password, hashedPassword)

  findByEmail: (email, callback) =>
    @app.db.users.find({'email': email}, (err, users) =>        
        if !err
          callback(null, users)
        else
          error = new @app.restify.InternalError(err)
          callback(error, null)
      )

  createAccount: (data, callback) =>    
    if not @validate(data, "createAccount")
      callback(new @app.restify.InvalidArgumentError("Validation failed"))
      return
    
    @findByEmail(data.email, (err, users) =>
      if err == null
        if users.length == 0
          hashedPassword = @hashPassword(data.password)
          user = {
            'email':data.email, 
            'name':data.name, 
            'hashedPassword': hashedPassword, 
            'rating': 1400}
          @saveUser(user, (err, saved) ->              
              callback(err)
            )
        else
          callback(new @app.restify.InvalidArgumentError('User with same email already in database'))
      else
        callback(new @app.restify.InvalidArgumentError(err))        
      )

  saveUser: (user, callback) =>    
    if not @validate(user, "saveUser")
      throw new @app.restify.InternalError('User not valid')
    @app.db.users.save(user, (err, saved) =>
        error = null;
        if err  
          error = new @app.restify.InternalError(err)
        callback(error, saved) 
      )

  login: (data, callback) =>
    @findByEmail(data.email, (err, users) =>
        if users.length == 1          
          if @checkPassword(data.password, users[0].hashedPassword)
            @generateNewAuthToken((authToken) =>
                users[0].authToken = authToken
                @saveUser(users[0], (error, saved) =>
                  callback(error, authToken)
                )
              )
          else          
            callback(new @app.restify.InvalidArgumentError('Email or password wrong'), null)  
        else          
          callback(new @app.restify.InvalidArgumentError('Email or password wrong'), null)
      )
      
  generateNewAuthToken: (callback) =>
    crypto.randomBytes(48, (ex, buf) =>
      authToken = buf.toString('hex')
      callback(authToken)
      )

  getUserByAuthToken: (authToken, callback) =>    
    @app.db.users.find({authToken: authToken}, (err, users) =>
      if !err
        if users.length == 0          
          callback(new @app.restify.NotAuthorizedError('Token not found'), null)
        callback(null, users[0])
      else
        callback(new @app.restify.InternalError(err), null)
      )

module.exports = (app) -> new User(app)