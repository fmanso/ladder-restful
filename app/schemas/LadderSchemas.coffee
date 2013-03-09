module.exports = {
  "addMatch": {
    "description": "Input for addMatch",
    "type": "object",
    "properties": {
      "scoreA": {
        "type": "number",
        "required": true     
      },
      "scoreB": {
        "type": "number",
        "required": true
      },
      "userA": {
        "type": "string",
        "required": true
      },
      "userB": {
        "type": "string",
        "required": true
      }
    }
  }  
}