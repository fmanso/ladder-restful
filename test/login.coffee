assert = require('assert')
bcrypt = require('bcrypt')
test = require('./test')

user1 = {
  name: 'user1',
  email: 'user1@email.com',  
  password: '12345'
}

describe('Login', ()->  
  before (done) ->      
    salt = bcrypt.genSaltSync(10)    
    hashedPassword = bcrypt.hashSync(user1.password, salt)    
    user = {
      'name':user1.name, 
      'email':user1.email, 
      'hashedPassword': hashedPassword,
      'rating': 1400}    
    test.db.users.save(user, (err, saved) -> 
      done()
    )
    

  it('should get a 200 response', (done) ->
    test.client.post('/api/login', { email: user1.email, password: user1.password }, (err, req, res, data) ->                    
      assert.equal(null, err)
      assert.equal(200, res.statusCode) 
      assert.equal(true, data.authToken.length > 0)
      done()      
    )      
  )

  it('should get an error when email is not registered', (done) ->
    test.client.post('/api/login', { email: 'user@lol.com', password: user1.password}, (err, req, res, data) ->
      assert.notEqual(null, err)      
      done()
    )
  )

  it('should get an error when password is wrong', (done) ->
    test.client.post('/api/login', { email: user1.email, password: "54321"}, (err, req, res, data) ->
      assert.notEqual(null, err)      
      done()
    )
  )

  after (done) ->
    test.db.users.remove({email: user1.email}, () ->
      done()
    )
  )