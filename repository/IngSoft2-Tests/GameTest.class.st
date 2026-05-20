Class {
	#name : 'GameTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001ifTheBoardHasLessThanOneSquareThenTheBoardIsNotValid [

	| ships dicePool laps parsecs squares numberOfShips |
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: 1) }.
	laps := 1.
	parsecs := 1.

	squares := 0.
	self
		should: [
			Game
				withSquares: squares
				andShips: ships
				andDicePool: dicePool
				andLaps: laps
				andParsecs: parsecs ]
		raiseErrorWithMessageText: 'The board must have at least 1 square.'
]

{ #category : 'tests' }
GameTest >> test002whenBoardIsCreatedWithLessThanTwoShipsThenIsNotValid [

	| ships dicePool laps parsecs squares numberOfShips |
	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: 1) }.
	laps := 1.
	parsecs := 1.
	squares := 10.

	numberOfShips := 1.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].

	self
		should: [
			Game
				withSquares: squares
				andShips: ships
				andDicePool: dicePool
				andLaps: laps
				andParsecs: parsecs ]
		raiseErrorWithMessageText: 'The board must have at least 2 ships.'
]

{ #category : 'tests' }
GameTest >> test003WhenLoadedWithOnlyOneDiceThenIsValid [

	| preloadedDice dicePool laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].

	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.


	self
		shouldnt: [
			Game
				withSquares: squares
				andShips: ships
				andDicePool: dicePool
				andLaps: laps
				andParsecs: parsecs ]
		raise: Error
]

{ #category : 'tests' }
GameTest >> test004WhenLoadedWithACertainAmountOfDiceWithDifferentFacesThenIsValid [

	| preloadedDice1 preloadedDice2 dicePool laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	
	preloadedDice1 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	preloadedDice2 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: {
			            preloadedDice1.
			            preloadedDice2 }.
	self
		shouldnt: [
			Game
				withSquares: squares
				andShips: ships
				andDicePool: dicePool
				andLaps: laps
				andParsecs: parsecs ]
		raise: Error
]

{ #category : 'tests' }
GameTest >> test005BoardCreatesAlistOfShipsInPosition1 [

	| preloadedDice dicePool game laps parsecs squares ships listOfShips numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	listOfShips := {
		               { '1'. 1 }.
		               { '2'. 1 } }.

	self assert: (self positionOf: #('1' '2') in: game ) equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test006FirstPlayerShouldThrowDicesFirst [

	| preloadedDice dicePool game laps parsecs squares ships listOfShips numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	listOfShips := {
		               { '1'. 5 }.
		               { '2'. 1 } }.

	game nextTurn.
	self
		assert: (self positionOf: #( '1' '2' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test007SecondPlayerThrowsDice [

	| preloadedDice dicePool game laps parsecs squares ships listOfShips numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	listOfShips := {
		               { '1'. 5 }.
		               { '2'. 3 } }.

	game nextTurn.
	game nextTurn.
	self assert: (self positionOf: #( '1' '2' ) in: game) equals: listOfShips 
]

{ #category : 'tests' }
GameTest >> test008TwoPlayerPlaysTwoTimesEach [

	| preloadedDice dicePool game laps parsecs squares ships listOfShips numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	1 to: 4 do: [ :turn | game nextTurn ].

	listOfShips := {
		               { '1'. 9 }.
		               { '2'. 5 } }.

	
	self
		assert: (self positionOf: #( '1' '2' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test009IfASpaceshipGoesBeyondTheLastSquareItWins [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 9.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	1 to: 5 do: [ :turn | game nextTurn ].

	self assert: game gameIsOver 
]

{ #category : 'tests' }
GameTest >> test010WhenTheGameIsOverThenYouCantAskForNextTurn [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 9.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	1 to: 5 do: [ :turn | game nextTurn ].

	self should: [ game nextTurn ] raiseErrorWithMessageText: 'Game is over, no more turns allowed'
]

{ #category : 'tests' }
GameTest >> test011whenTheGameIsntOverThenYouCantAskForTheWinningShip [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 9.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	

	self should: [game whoWon] raiseErrorWithMessageText: 'Game isnt over'
]

{ #category : 'tests' }
GameTest >> test012whenTheGameIsOverThenYouCanAskForTheWinningShip [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 9.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	1 to: 5 do: [ :turn | game nextTurn ].

	self assert: game whoWon equals: (Spaceship withName: '1' andPosition: 13)
]

{ #category : 'tests' }
GameTest >> test013whenYouAskForASpaceShipPositionThenYouGetAResponse [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 11.
	numberOfShips := 4.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 4 2 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	1 to: 10 do: [ :turn | game nextTurn ].

	self assert: ((game locateSpaceShip: '1' ) at:#position) equals: 4
]

{ #category : 'tests' }
GameTest >> test014whenYouAskForAnUnrealSpaceShipPositionThenYouDontGetPosotion [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 1.
	parsecs := 1000.
	squares := 11.
	numberOfShips := 4.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 4 2 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	self
		should: [ game locateSpaceShip: 5 ]
		raiseErrorWithMessageText:
		'The selected SpaceShip is not on the board'
]

{ #category : 'tests' }
GameTest >> test015whenYouPlayWithLapsThenTheGameContinuesWhenAPLayerGoesBeyondTheLastSquare [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 2.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	5 timesRepeat: [ game nextTurn ].


	self deny: game gameIsOver
]

{ #category : 'tests' }
GameTest >> test016whenYouPlayWithLapsThenTheGameCanLocateTheExactSpaceShipPosotion [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 2.
	parsecs := 1000.
	squares := 11.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	5 timesRepeat: [ game nextTurn ].

	self assert: ((game locateSpaceShip: '1') at: #position) equals: 1
]

{ #category : 'tests' }
GameTest >> test017whenAPlayerReachsFinalLapThenTheGameIsOverAndThereAreNotMoreTurnsAllowed [

	| preloadedDice dicePool game laps parsecs squares ships numberOfShips |
	laps := 2.
	parsecs := 1000.
	squares := 10.
	numberOfShips := 2.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	11 timesRepeat: [ game nextTurn ].
	"""
	Expected position for spaceShip 1: 2 (the game finish because it was in the last lap)
	Expected position for spaceShip 2: 9 (it's in the first lap)
	"""
	self
		should: [ game nextTurn ]
		raiseErrorWithMessageText: 'Game is over, no more turns allowed'
]

{ #category : 'tests' }
GameTest >> test018whenYouAskForTheSpaceShipCurrentLapYouGetAResponse [

	| preloadedDice dicePool game laps parsecs squares ships lapsExpected numberOfShips |
	laps := 4.
	parsecs := 1000.
	squares := 5.
	numberOfShips := 4.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 3 2 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquares: squares
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	15 timesRepeat: [ game nextTurn ].

	lapsExpected := #( #( '1' 4 ) #( '2' 3 ) #( '3' 2 ) #( '4' 1 ) )
		                asOrderedCollection.

	lapsExpected do: [ :lap |
		self
			assert: ((game locateSpaceShip: lap first) at: #lap) == lap second
			equals: true ]
]

{ #category : 'tests' }
GameTest >> test019whenAPlayerReachTheAtomicBombSquareThenAllPlayersReturnToTheFirstSquareWithoutLoosingAnyLaps [

	| preloadedDice dicePool game laps parsecs ships lapsExpected positionsExpected numberOfShips |
	laps := 4.
	parsecs := 1000.
	numberOfShips := 3.
	ships := (1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)].
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 2 3 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := Game
		        withSquarePool: (MockSquarePool withPreloadedSquares: {
					         Square.
					         AtomicBomb.
					         Square.
					         Square.
					         Square })
		        andShips: ships
		        andDicePool: dicePool
		        andLaps: laps
		        andParsecs: parsecs.

	9 timesRepeat: [ game nextTurn ].

	lapsExpected := {
		                { '1'. 2 }.
		                { '2'. 2 }.
		                { '3'. 2 } }.

	positionsExpected := {
		                     { '1'. 1 }.
		                     { '2'. 1 }.
		                     { '3'. 1 } }.

	self
		assert: (self positionOf: #( '1' '2' '3' ) in: game)
		equals: positionsExpected.
	lapsExpected do: [ :lap |
			self
				assert: ((game locateSpaceShip: lap first) at: #lap) == lap second
				equals: true ]
]
