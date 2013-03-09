module.exports = {
  "createAccount": {
    "description": "Input for createAccount",
    "type": "object",
    "properties": {
      "name": {
        "type": "string",
        "required": true     
      },
      "email": {
        "type": "string",
        "required": true
      },
      "password": {
        "type": "string",
        "required": true
      },
    }
  },
  "saveUser": {
    "description": "Input for saveUser",
    "type": "object",
    "properties": {
      "name": {
        "type": "string",
        "required": true     
      },
      "email": {
        "type": "string",
        "required": true
      },
      "hashedPassword": {
        "type": "string",
        "required": true
      },
      "rating": {
        "type": "number",
        "required": true
      }
    }
  }
}