Class {
	#name : 'GameTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001ifTheBoardHasLessThan1000ParsecsThenTheBoardIsNotValid [

	| gameBuilder |
	gameBuilder := GameBuilder new withParsecs: 999.
	self
		should: [ gameBuilder build ]
		raiseErrorWithMessageText:
		'The board must have at least 1000 parsecs.'
]

{ #category : 'tests' }
GameTest >> test001ifTheBoardHasLessThanOneSquareThenTheBoardIsNotValid [

	| gameBuilder |
	gameBuilder := GameBuilder new withSquares: 0.
	self
		should: [ gameBuilder build ]
		raiseErrorWithMessageText: 'The board must have at least 1 square.'
]

{ #category : 'tests' }
GameTest >> test002whenBoardIsCreatedWithLessThanTwoShipsThenIsNotValid [

	| gameBuilder |
	gameBuilder := GameBuilder new withSpaceships:
		               { (Spaceship withName: 'nave') }.

	self
		should: [ gameBuilder build ]
		raiseErrorWithMessageText: 'The board must have at least 2 ships.'
]

{ #category : 'tests' }
GameTest >> test003WhenLoadedWithOnlyOneDiceThenIsValid [

	| preloadedDice dicePool gameBuilder |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.

	gameBuilder := GameBuilder new withDicepool: dicePool.
	self shouldnt: [ gameBuilder build ] raise: Error
]

{ #category : 'tests' }
GameTest >> test004WhenLoadedWithACertainAmountOfDiceWithDifferentFacesThenIsValid [

	| preloadedDice1 preloadedDice2 dicePool gameBuilder |
	preloadedDice1 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	preloadedDice2 := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: {
			            preloadedDice1.
			            preloadedDice2 }.

	gameBuilder := GameBuilder new withDicepool: dicePool.
	self shouldnt: [ gameBuilder build ] raise: Error
]

{ #category : 'tests' }
GameTest >> test005BoardCreatesAlistOfShipsInPosition1 [

	| game ships listOfShips |
	ships := {
		         (Spaceship withName: 'firstShip' asString).
		         (Spaceship withName: 'secondShip' asString) }.
	game := (GameBuilder new withSpaceships: ships) build.


	listOfShips := {
		               { 'firstShip'. 1 }.
		               { 'secondShip'. 1 } }.

	self
		assert: (self positionOf: #( 'firstShip' 'secondShip' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test006FirstPlayerShouldThrowDicesFirst [

	| preloadedDice dicePool game listOfShips |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withDicepool: dicePool;
		        build.

	listOfShips := {
		               { 'one'. 5 }.
		               { 'two'. 1 } }.

	game throwDiceNextTurn.
	self
		assert: (self positionOf: #( 'one' 'two' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test007SecondPlayerThrowsDice [

	| preloadedDice dicePool game listOfShips |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withDicepool: dicePool;
		        build.

	listOfShips := {
		               { 'one'. 5 }.
		               { 'two'. 3 } }.

	game throwDiceNextTurn.
	game throwDiceNextTurn.
	self
		assert: (self positionOf: #( 'one' 'two' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test008TwoPlayerPlaysTwoTimesEach [

	| preloadedDice dicePool game listOfShips |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withDicepool: dicePool;
		        build.

	1 to: 4 do: [ :turn | game throwDiceNextTurn ].

	listOfShips := {
		               { 'one'. 9 }.
		               { 'two'. 5 } }.


	self
		assert: (self positionOf: #( 'one' 'two' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
GameTest >> test009IfASpaceshipGoesBeyondTheLastSquareItWins [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSquares: 9;
		        withDicepool: dicePool;
		        build.

	1 to: 5 do: [ :turn | game throwDiceNextTurn ].

	game winningSpaceship.

	self assertDictionary: game winningSpaceship contains: {
			(#name -> 'one').
			(#position -> 4).
			(#lap -> 2) } asDictionary
]

{ #category : 'tests' }
GameTest >> test010WhenTheGameIsOverThenYouCantAskForNextTurn [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSquares: 9;
		        withDicepool: dicePool;
		        build.

	1 to: 5 do: [ :turn | game throwDiceNextTurn ].

	self
		should: [ game throwDiceNextTurn ]
		raiseErrorWithMessageText: 'Game is over, no more turns allowed'
]

{ #category : 'tests' }
GameTest >> test011whenTheGameIsntOverThenYouCantAskForTheWinningShip [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSquares: 9;
		        withDicepool: dicePool;
		        build.

	self
		should: [ game winningSpaceship ]
		raiseErrorWithMessageText: 'Game is not over'
]

{ #category : 'tests' }
GameTest >> test013whenYouAskForASpaceShipPositionThenYouGetAResponse [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 4 2 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSquares: 11;
		        withDicepool: dicePool;
		        withSpaceships:
			        ((1 to: 4) collect: [ :number |
					         Spaceship withName: number asString ]);
		        build.

	1 to: 10 do: [ :turn | game throwDiceNextTurn ].

	self assert: ((game spaceshipNamed: '1') at: #position) equals: 4
]

{ #category : 'tests' }
GameTest >> test014whenYouAskForASpaceshipThatDoesNotExistThenYouDontGetPosotion [

	| game |
	game := GameBuilder new
		        withSpaceships:
			        ((1 to: 4) collect: [ :number |
					         Spaceship withName: number asString ]);
		        build.

	self
		should: [ game spaceshipNamed: '5' ]
		raiseErrorWithMessageText:
		'Ship not found.'
]

{ #category : 'tests' }
GameTest >> test015whenYouPlayWithLapsThenTheGameContinuesWhenAPLayerGoesBeyondTheLastSquare [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withLaps: 2;
		        build.

	5 timesRepeat: [ game throwDiceNextTurn ].

	self
		should: [ game winningSpaceship ]
		raiseErrorWithMessageText: 'Game is not over'
]

{ #category : 'tests' }
GameTest >> test016whenYouPlayWithLapsThenTheGameCanLocateTheExactSpaceShipPosotion [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSquares: 11;
		        withLaps: 2;
		        withDicepool: dicePool;
		        build.

	5 timesRepeat: [ game throwDiceNextTurn ].

	self assert: ((game spaceshipNamed: 'one') at: #position) equals: 1
]

{ #category : 'tests' }
GameTest >> test017whenAPlayerReachsFinalLapThenTheGameIsOverAndThereAreNotMoreTurnsAllowed [

	| preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 3 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withLaps: 2;
		        withDicepool: dicePool;
		        build.

	11 timesRepeat: [ game throwDiceNextTurn ].
	"""
	Expected position for spaceShip 1: 2 (the game finish because it was in the last lap)
	Expected position for spaceShip 2: 9 (it's in the first lap)
	"""
	self
		should: [ game throwDiceNextTurn ]
		raiseErrorWithMessageText: 'Game is over, no more turns allowed'
]

{ #category : 'tests' }
GameTest >> test018whenYouAskForTheSpaceShipCurrentLapYouGetAResponse [

	| preloadedDice dicePool game lapsExpected |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 2 1 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSquares: 5;
		        withLaps: 4;
		        withDicepool: dicePool;
		        withSpaceships:
			        ((1 to: 4) collect: [ :number |
					         Spaceship withName: number asString ]);
		        build.

	15 timesRepeat: [ game throwDiceNextTurn ].

	lapsExpected := #( #( '1' 4 ) #( '2' 2 ) #( '3' 1 ) #( '4' 2 ) )
		                asOrderedCollection.

	lapsExpected do: [ :lap |
			self
				assert: ((game spaceshipNamed: lap first) at: #lap)
				identicalTo: lap second ]
]

{ #category : 'tests' }
GameTest >> test019whenAPlayerReachTheAtomicBombSquareThenAllPlayersReturnToTheFirstSquareWithoutLoosingAnyLaps [

	| preloadedDice dicePool game lapsExpected positionsExpected mockSquarePool |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 2 3 4 ).
	dicePool := DicePool withDice: { preloadedDice }.
	mockSquarePool := MockBoardBuilder new withEffects: {
			                  Square new.
			                  AtomicBomb new.
			                  Square new.
			                  Square new.
			                  Square new}.
	game := GameBuilder new
		        withLaps: 4;
		        withSpaceships:
			        ((1 to: 3) collect: [ :number |
					         Spaceship withName: number asString ]);
		        withDicepool: dicePool;
		        withBoardBuilder: mockSquarePool;
		        build.


	9 timesRepeat: [ game throwDiceNextTurn ].

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
				assert: ((game spaceshipNamed: lap first) at: #lap)
				identicalTo: lap second ]
]

{ #category : 'tests' }
GameTest >> test020GameCanProvideTheCurrentRankingOfShips [

	| preloadedDice dicePool game ranking namesAt |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 3 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSpaceships:
			        ((1 to: 3) collect: [ :number |
					         Spaceship withName: number asString ]);
		        withDicepool: dicePool;
		        build.

	3 timesRepeat: [ game throwDiceNextTurn ].

	ranking := game ranking.
	namesAt := [ :rank |
	           ((ranking at: rank) collect: [ :ship | ship name ])
		           asArray ].
	self assert: (namesAt value: #first) equals: #( '1' ).
	self assert: (namesAt value: #second) equals: #( '2' ).
	self assert: (namesAt value: #third) equals: #( '3' )
]

{ #category : 'tests' }
GameTest >> test021spaceshipsStartTheGameWithTwoCartsFromDesk [

	| mockDeck sequence spaceshipManager spaceships game |
	sequence := { Redo new. Acceleration new . Speed new } .
	mockDeck := DeckMock withSequence: sequence.
	spaceships := { Spaceship withName: 'player_1' . Spaceship withName: 'player_2' } .
	spaceshipManager := SpaceshipManager withSpaceships: spaceships .
	
	game := GameBuilder new
	   withSpaceships: spaceships;
	   withDeck: mockDeck;
	   build
	.
	
	self assert:( (spaceships at: 1) playCard: (sequence at: 1) ) equals: (sequence at: 1).
	self assert:( (spaceships at: 1) playCard: (sequence at: 2) ) equals: (sequence at: 2).
	self assert:( (spaceships at: 2) playCard: (sequence at: 3) ) equals: (sequence at: 3).
	self assert:( (spaceships at: 2) playCard: (sequence at: 1) ) equals: (sequence at: 1).
]
