assert = require('assert')
test = require('./test')

user1 = {
  name: 'user1',
  email: 'user1@email.com',  
  password: '12345'
}

userWithoutPassword = {
  name: 'user1',
  email: 'user1@gmail.com'
}

userWithoutEmail = {
  name: 'user1',
  password: '12345'  
}

userWithoutName = {  
  email: 'user1@email.com',  
  password: '12345'
}

describe('Create new account', ()->  
  before (done) ->     
    done()

  after (done) ->
    test.db.users.remove({email: 'user1@email.com'}, () ->
      done()
    )
  

  it('should get a 200 response', (done) ->
    test.client.put('/api/users', user1, (err, req, res, data) ->                    
      assert.equal(null, err)
      assert.equal(200, res.statusCode) 
      done()      
    )      
  )
)

describe('Create new account', ()->  
  before (done) ->     
    test.db.users.save(user1, (err, saved) ->
      done()
    )

  it('should get an error response if email already exists', (done) ->
    test.client.put('/api/users', user1, (err, req, res, data) ->                    
      assert.notEqual(null, err)
      assert.notEqual(200, res.statusCode) 
      done()      
    )      
  )

  it('should get an error response if email data is missing', (done) ->
    test.client.put('/api/users', userWithoutEmail, (err, req, res, data) ->
      assert.notEqual(null, err)
      assert.notEqual(200, res.statusCode) 
      done()      
    )      
  )

  it('should get an error response if name data is missing', (done) ->
    test.client.put('/api/users', userWithoutName, (err, req, res, data) ->
      assert.notEqual(null, err)
      assert.notEqual(200, res.statusCode) 
      done()      
    )      
  )

  it('should get an error response if password data is missing', (done) ->
    test.client.put('/api/users', userWithoutPassword, (err, req, res, data) ->
      assert.notEqual(null, err)
      assert.notEqual(200, res.statusCode) 
      done()      
    )      
  )

  after (done) ->
    test.db.users.remove({}, () -> done() )   
  )