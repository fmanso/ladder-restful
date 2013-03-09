class LadderController
  constructor: (@app) ->
    console.log 'LadderController Initialized'
    @ladderModel = new require('../models/Ladder')(@app)
    @userModel = new require('../models/User')(@app)
  
  addMatch: (req, res, next) =>    
    @userModel.getUserByAuthToken(req.params.authToken, (error, user) =>
      if error != null
        return next error

      match = {
        'scoreA': req.params.scoreA,
        'scoreB': req.params.scoreB,
        'userA': req.params.userA,
        'userB': req.params.userB
      }

      @ladderModel.addMatch(match, (err) =>
        if err == null
          res.send('')
          return next()
        else
          return next err
      )
    )    

  getTable: (req, res, next) =>    
    @ladderModel.getTable((error, table) =>
      if error == null
        res.json table        
        return next()
      else
        return next error
    )      
    


module.exports = (app) -> app.LadderController = new LadderController(app);