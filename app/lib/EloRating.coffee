# https://github.com/hugodias/EloRating-JavaScript/blob/master/lib/elo_rating.coffee

class EloRating
  constructor: (ratingA, ratingB, scoreA, scoreB) ->
    # the K factor used
    @KFACTOR = 16   

    @_ratingA = ratingA
    @_ratingB = ratingB
    @_scoreA = scoreA
    @_scoreB = scoreB

    expectedScores = @_getExpectedScores @_ratingA,@_ratingB
    @_expectedA = expectedScores.a
    @_expectedB = expectedScores.b

    newRatings = @_getNewRatings @_ratingA, @_ratingB, @_expectedA, @_expectedB, @_scoreA, @_scoreB
    @_newRatingA = newRatings.a
    @_newRatingB = newRatings.b

  setNewSetings: (ratingA, ratingB, scoreA, scoreB) ->
    @_ratingA = ratingA
    @_ratingB = ratingB
    @_scoreA = scoreA
    @_scoreB = scoreB

    expectedScores = @_getExpectedScores @_ratingA, @_ratingB
    @_expectedA = expectedScores.a
    @_expectedB = expectedScores.b  

    newRatings = @_getNewRatings @_ratingA, @_ratingB, @_expectedA, @_expectedB, @_scoreA, @_scoreB
    @_newRatingA = newRatings.a
    @_newRatingB = newRatings.b


  getNewRatings: () ->
    ratings = {
       a: Math.round @_newRatingA
       b: Math.round @_newRatingB     
    }


  _getExpectedScores: (ratingA, ratingB) ->
    expectedScoreA = 1 / ( 1 + Math.pow 10, ( ratingB - ratingA ) / 400 ) 
    expectedScoreB = 1 / ( 1 + Math.pow 10, ( ratingA - ratingB ) / 400 )

    expected = {
      a: expectedScoreA
      b: expectedScoreB
    }


  _getNewRatings: (ratingA, ratingB, expectedA, expectedB, scoreA, scoreB) ->
    newRatingA = ratingA + ( @KFACTOR * ( scoreA - expectedA ) )
    newRatingB = ratingB + ( @KFACTOR * ( scoreB - expectedB ) )

    ratings = {
      a: newRatingA
      b: newRatingB     
    }

module.exports = EloRating