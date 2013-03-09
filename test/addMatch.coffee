assert = require('assert')
test = require('./test')

user1 = {
  name: 'user1',
  email: 'user1@email.com',  
  hashedPassword: '12345',
  authToken: 'a12345',
  rating: 1400
}

user2 = {
  name: 'user2',
  email: 'user2@email.com',  
  hashedPassword: '12345',
  rating: 1400
}

describe('Add Match', ()->  
  before (done) ->      
    test.db.users.save(user1, (err, saved) -> 
      test.db.users.save(user2, (err, saved) ->
        done()
      )
    )
    
  it('should modify user\'s rating', (done) ->
    match =  {
      scoreA: 5,
      scoreB: 0,
      userA: user1._id,
      userB: user2._id,
      authToken: user1.authToken
    }

    test.client.put('/api/matches', match, (err, req, res, data) ->
      assert.equal(null, err)
      assert.equal(200, res.statusCode)     
      test.db.users.find({email:user1.email}, (err, userA) ->
        test.db.users.find({email:user2.email}, (err, userB) ->
          assert.notEqual(userA[0].rating, userA.rating)
          assert.notEqual(userB[0].rating, userB.rating)
          done()
        )
      )
    )    
  )

  after (done) ->    
    test.db.users.remove({email: user1.email}, () ->
      test.db.users.remove({email: user2.email}, () ->
        done()
      )
    )
  )