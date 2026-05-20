Class {
	#name : 'GameTest',
	#superclass : 'ProjectTestCase',
	#instVars : [
		'listOfShips'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001ifTheBoardHasLessThanOneSquareThenTheBoardIsNotValid [

	self
		should: [ Game withPreloadedSquares: 0 ]
		raiseErrorWithMessageText: 'The board must have at least 1 square.'
]

{ #category : 'tests' }
GameTest >> test002whenBoardIsCreatedWithLessThanTwoShipsThenIsNotValid [

	self
		should: [ Game withShips: 1 ]
		raiseErrorWithMessageText: 'The board must have at least 2 ships.'
]

{ #category : 'tests' }
GameTest >> test003WhenLoadedWithOnlyOneDiceThenIsValid [

	| preloadedDice dicePool |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.


	self
		shouldnt: [ Game withSquares: 10 andShips: 2 andDicePool: dicePool ]
		raise: Error
]

{ #category : 'tests' }
GameTest >> test004WhenLoadedWithACertainAmountOfDiceWithDifferentFacesThenIsValid [

	| preloadedDice1 preloadedDice2 dicePool |
	preloadedDice1 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	preloadedDice2 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: {
			            preloadedDice1.
			            preloadedDice2 }.
	self
		shouldnt: [ Game withSquares: 10 andShips: 2 andDicePool: dicePool ]
		raise: Error
]

{ #category : 'tests' }
GameTest >> test005BoardCreatesAlistOfShipsInPosition1 [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 10 andShips: 2 andDicePool: dicePool.

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 1).
		               (Spaceship withName: 2 andPosition: 1) } asOrderedCollection .
		
	self assert: board ships equals: listOfShips 
]

{ #category : 'tests' }
GameTest >> test006FirstPlayerShouldThrowDicesFirst [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 10 andShips: 2 andDicePool: dicePool.

	board nextTurn.

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 5).
		               (Spaceship withName: 2 andPosition: 1) }
		               asOrderedCollection.

	self assert: board ships equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test007SecondPlayerThrowsDice [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 10 andShips: 2 andDicePool: dicePool.

	board nextTurn.
	board nextTurn.

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 5).
		               (Spaceship withName: 2 andPosition: 3) }
		               asOrderedCollection.

	self assert: board ships equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test008TwoPlayerPlaysTwoTimesEach [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 10 andShips: 2 andDicePool: dicePool.

	1 to: 4 do: [ :turn | board nextTurn ].

	listOfShips := {
		               (Spaceship withName: 1 andPosition: 9).
		               (Spaceship withName: 2 andPosition: 5) }
		               asOrderedCollection.

	self assert: board ships equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test009IfASpaceshipGoesBeyondTheLastSquareItWins [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 9 andShips: 2 andDicePool: dicePool.

	1 to: 5 do: [ :turn | board nextTurn ].

	self assert: board gameIsOver 
]

{ #category : 'tests' }
GameTest >> test010WhenTheGameIsOverThenYouCantAskForNextTurn [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 9 andShips: 2 andDicePool: dicePool.

	1 to: 5 do: [ :turn | board nextTurn ].

	self should: [ board nextTurn ] raiseErrorWithMessageText: 'Game is over, no more turns allowed'
]

{ #category : 'tests' }
GameTest >> test011whenTheGameIsntOverThenYouCantAskForTheWinningShip [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 9 andShips: 2 andDicePool: dicePool.

	self should: [board whoWon] raiseErrorWithMessageText: 'Game isnt over'
]

{ #category : 'tests' }
GameTest >> test012whenTheGameIsOverThenYouCanAskForTheWinningShip [

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 9 andShips: 2 andDicePool: dicePool.

	1 to: 5 do: [ :turn | board nextTurn ].

	self assert: board whoWon equals: (Spaceship withName: 1 andPosition: 13)
]

{ #category : 'tests' }
GameTest >> test013whenYouAskForASpaceShipPositionThenYouGetAResponse [ 

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 4 2 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 11 andShips: 4 andDicePool: dicePool.

	1 to: 10 do: [ :turn | 
		board nextTurn ].

	self assert: (board locateSpaceShip: 1 ) equals: 4
]

{ #category : 'tests' }
GameTest >> test014whenYouAskForAnUnrealSpaceShipPositionThenYouDontGetPosotion [ 

	| preloadedDice dicePool board |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 4 2 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	board := Game withSquares: 11 andShips: 4 andDicePool: dicePool.
	
	self should: [ board locateSpaceShip: 5 ] raiseErrorWithMessageText: 'The selected SpaceShip is not on the board'

]

{ #category : 'tests' }
GameTest >> test015whenYouPlayWithLapsThenTheGameContinuesWhenAPLayerGoesBeyondTheLastSquare [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game withSquares: 10 andShips: 2 andDicePool: dicePool andLaps: 2.

	5 timesRepeat: [ game nextTurn ].

	
	self deny: game gameIsOver 
]

{ #category : 'tests' }
GameTest >> test016whenYouPlayWithLapsThenTheGameCanLocateTheExactSpaceShipPosotion [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game withSquares: 11 andShips: 2 andDicePool: dicePool andLaps: 2.

	5 timesRepeat: [ game nextTurn ].
	
	self assert: (game locateSpaceShip: 1 ) equals: 1
]

{ #category : 'tests' }
GameTest >> test017whenAPlayerReachsFinalLapThenTheGameIsOverAndThereAreNotMoreTurnsAllowed [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game withSquares: 10 andShips: 2 andDicePool: dicePool andLaps: 2.

	11 timesRepeat: [ game nextTurn ].
	"""
	Expected position for spaceShip 1: 2 (the game finish because it was in the last lap)
	Expected position for spaceShip 2: 9 (it's in the first lap)
	"""
   self should: [ game nextTurn ] raiseErrorWithMessageText: 'Game is over, no more turns allowed'
]

{ #category : 'tests' }
GameTest >> test018whenYouAskForTheSpaceShipCurrentLapYouGetAResponse [

	| preloadedDice dicePool game lapsExpected |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 3 2 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game withSquares: 5 andShips: 4 andDicePool: dicePool andLaps: 4.

	15 timesRepeat: [ game nextTurn].
	
	lapsExpected := #( (1 4) (2 3) (3 2) (4 1) ) asOrderedCollection .

   lapsExpected do: [:lap |
	   self assert: ((game currentSpaceShipLap: lap first) == lap second ) equals: true.
   ]

]

{ #category : 'tests' }
GameTest >> test019whenAPlayerReachTheAtomicBombSquareThenThePlayersReturnToTheFisrtSquareWithoutLossingAnyLap [

	| preloadedDice dicePool game lapsExpected aSqarePool positionsExpected |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 2 3 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	aSqarePool := MockSquarePool withPreloadedSquares: { Square. AtomicBomb. Square. Square. Square }.
	game := Game withSquarePool: aSqarePool andShips: 3 andDicePool: dicePool andLaps: 4.

	9 timesRepeat: [ game nextTurn ].
	
	lapsExpected := #( (1 2) (2 2) (3 2) ) asOrderedCollection .	
   positionsExpected := #( (1 6) (2 11) (3 6) ) asOrderedCollection .

   lapsExpected do: [:lap |
	   self assert: ((game currentSpaceShipLap: lap first) == lap second ) equals: true.
   ]."
   positionsExpected do: [:position |
	   self assert: ((game locateSpaceShip: position first) == position second ) equals: true.
   ]"

]
