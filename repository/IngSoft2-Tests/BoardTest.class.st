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
BoardTest >> test001ifTheBoardHasLessThanOneSquareThenTheBoardIsNotValid [

	self
		should: [ Board withSquares: 0 ]
		raiseErrorWithMessageText: 'The board must have at least 1 square.'
]

{ #category : 'tests' }
BoardTest >> test002whenBoardIsCreatedWithLessThanTwoShipsThenIsNotValid [

	self
		should: [ Board withShips: 1 ]
		raiseErrorWithMessageText: 'The board must have at least 2 ships.'
]

{ #category : 'tests' }
BoardTest >> test003WhenLoadedWithOnlyOneDiceThenIsValid [

	| preloadedDice dicePool |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.


	self
		shouldnt: [ Board withSquares: 10 andShips: 2 andDicePool: dicePool ]
		raise: Error
]

{ #category : 'tests' }
BoardTest >> test004WhenLoadedWithACertainAmountOfDiceWithDifferentFacesThenIsValid [

	| preloadedDice1 preloadedDice2 dicePool |
	preloadedDice1 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	preloadedDice2 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: {
			            preloadedDice1.
			            preloadedDice2 }.
	Board withSquares: 10 andShips: 2 andDicePool: dicePool
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

{ #category : 'tests' }
BoardTest >> test006FirstPlayerShouldThrowDicesFirst [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 10 andShips: 2 andDicePool: dicePool.
	
	
	board nextTurn.

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 5).
		               (Spaceship withName: 2 andPosition: 1) } asOrderedCollection .
		
	
		
	self assert: board ships equals: listOfShips 
]

{ #category : 'tests' }
BoardTest >> test007SecondPlayerThrowsDice [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 10 andShips: 2 andDicePool: dicePool.
	
	
	board nextTurn.
	board nextTurn.

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 5).
		               (Spaceship withName: 2 andPosition: 3) } asOrderedCollection .
		
	
		
	self assert: board ships equals: listOfShips 
]

{ #category : 'tests' }
BoardTest >> test008TwoPlayerPlaysTwoTimesEach [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 10 andShips: 2 andDicePool: dicePool.

	1 to: 4 do: [ :turn | board nextTurn ].

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 9).
		               (Spaceship withName: 2 andPosition: 5) }
		               asOrderedCollection.

	self assert: board ships equals: listOfShips
]

{ #category : 'tests' }
BoardTest >> test009IfASpaceshipReachTheLastSquareItWins [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 9 andShips: 2 andDicePool: dicePool.

	1 to: 3 do: [ :turn | board nextTurn ].

	self assert: board gameIsOver 
]

{ #category : 'tests' }
BoardTest >> test010WhenTheGameIsOverThenYouCantAskForNextTurn [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 9 andShips: 2 andDicePool: dicePool.

	1 to: 3 do: [ :turn | board nextTurn ].

	self should: [ board nextTurn ] raiseErrorWithMessageText: 'Game is over, no more turns allowed'
]

{ #category : 'tests' }
BoardTest >> test011whenTheGameIsntOverThenYouCantAskForTheWinningShip [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 9 andShips: 2 andDicePool: dicePool.

	self should: [board whoWon] raiseErrorWithMessageText: 'Game isnt over'
]

{ #category : 'tests' }
BoardTest >> test012whenTheGameIsOverThenYouCanAskForTheWinningShip [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 9 andShips: 2 andDicePool: dicePool.

	1 to: 3 do: [ :turn | board nextTurn ].

	self assert: board whoWon equals: (Spaceship withName: 1 andPosition: 9)
]

{ #category : 'tests' }
BoardTest >> test014whenYouAskForASpaceShipPositionThenYouGetAResponse [ 

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 4 2 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 11 andShips: 4 andDicePool: dicePool.

	1 to: 10 do: [ :turn | 
		board nextTurn ].

	self assert: (board locateSpaceShip: 1 ) equals: 4
]

{ #category : 'tests' }
BoardTest >> test015whenYouAskForAnUnrealSpaceShipPositionThenYouDontGetPosotion [ 

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 4 2 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Board withSquares: 11 andShips: 4 andDicePool: dicePool.

	1 to: 10 do: [ :turn | 
		board nextTurn ].

	
	self should: [ board locateSpaceShip: 5 ] raiseErrorWithMessageText: 'The selected SpaceShip is not on the board'

]
