Class {
	#name : 'BoardTest',
	#superclass : 'ProjectTestCase',
	#instVars : [
		'listOfShips'
	],
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
BoardTest >> test004WhenLoadedWithACertainAmountOfDiceWithDifferentFacesThenIsValid [

	| preloadedDice1 preloadedDice2 dicePool |
	preloadedDice1 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	preloadedDice2 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: {
			            preloadedDice1.
			            preloadedDice2 }.

	self
		shouldnt: [ Board withSquares: 10 andShips: 2 andDicePool: dicePool ]
		raise: Error
]

{ #category : 'tests' }
BoardTest >> test005BoardCreatesAlistOfShipsInPosition1 [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 10 andShips: 2 andDicePool: dicePool.

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 1).
		               (Spaceship withName: 2 andPosition: 1) } asOrderedCollection .
		
	self assert: board ships equals: listOfShips 
]
