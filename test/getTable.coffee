assert = require('assert')
test = require('./test')

user1 = {
  name: 'user1',
  email: 'user1@email.com',  
  hashedPassword: '12345',
  rating: 1400,
  authToken: 'as123'
}

user2 = {
  name: 'user2',
  email: 'user2@email.com',  
  hashedPassword: '12345',
  rating: 1400,
  authToken: 'as123'
}

describe('Get Table', ()->  
  before (done) ->      
    test.db.users.save(user1, (err, saved) -> 
      test.db.users.save(user2, (err, saved) ->
        done()
      )
    )
    
  it('should get the table', (done) ->        
    test.client.get('/api/ladder', (err, req, res, data) ->
      assert.equal(null, err)
      assert.equal(200, res.statusCode)
      assert.notEqual(0, data.length) 
      assert.equal(null, data[0].hashedPassword)     
      assert.equal(null, data[0].authToken)     
      assert.notEqual(null, data[0].name)
      assert.notEqual(null, data[0].rating)
      done()      
    )    
  )

  after (done) ->
    test.db.users.remove({email: user1.email}, () ->
      test.db.users.remove({email: user2.email}, () ->
        done()
      )
    )
  )