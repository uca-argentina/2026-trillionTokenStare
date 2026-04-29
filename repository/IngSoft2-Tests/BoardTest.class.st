Class {
	#name : 'BoardTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001whenTheBoardIsCreatedThenTheBoardExists [
	| board |
	board := Board new.
	self assert: (board isMemberOf: Board).

	
]

{ #category : 'tests' }
BoardTest >> test002ifTheBoardHasLessThanOneSquareThenTheBoardIsNotValid [

	self
		should: [ Board withSquares: 0 ]
		raiseErrorWithMessageText: 'The board must have at least 1 square.'
]

{ #category : 'tests' }
BoardTest >> test003whenBoardIsCreatedWithLessThanTwoShipsThenIsNotValid [

	self
		should: [ Board withShips: 1 ]
		raiseErrorWithMessageText: 'The board must have at least 2 ships.'
]

{ #category : 'tests' }
BoardTest >> test004whenBoardCreatedWithMoreThan1SquareAndMoreThan2ShipsThenIsValid [

	self shouldnt: [ Board withSquares: 10 andShips: 2 ] raise: Error
]
