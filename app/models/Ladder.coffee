EloRating = require('../lib/EloRating')
mongojs = require('mongojs')
ObjectId = mongojs.ObjectId

class Ladder
  constructor: (@app) ->    

  addMatch: (match, callback) =>     
    @app.db.users.find({$or: [{_id: ObjectId(match.userA)}, {_id: ObjectId(match.userB)}]}, 
      {'hashedPassword':0}
      (err, users) =>
        if users.length == 2
          userA = {}
          userB = {}
          if (users[0]._id == match.userA) 
            userA = users[0]
            userB = users[1]
          else 
            userA = users[1]
            userB = users[0]

          elo = new EloRating(userA.rating, userB.rating, match.scoreA, match.scoreB)
          newRatings = elo.getNewRatings()

          userA.rating = newRatings.a
          userB.rating = newRatings.b

          @app.db.users.save(userA, (err, saved) =>
            @app.db.users.save(userB, (err, saved) =>
              callback(null)
            )
          )        
        else
          callback(new @app.restify.InvalidArgumentError("Users not found on database"))
      )

  getTable: (callback) ->
    @app.db.users.find({}, {'hashedPassword':0, 'authToken':0}, (err, users) =>
      if err
        callback(new @app.restify.InternalError(err), null)
      else
        callback(null, users)
      )


module.exports = (app) -> new Ladder(app)