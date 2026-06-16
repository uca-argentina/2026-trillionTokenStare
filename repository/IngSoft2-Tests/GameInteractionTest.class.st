Class {
	#name : 'GameInteractionTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameInteractionTest >> test001ifTheBoardHasLessThan1000ParsecsThenTheBoardIsNotValid [

	| gameBuilder |
	gameBuilder := GameBuilder new withParsecs: 999.
	self
		should: [ gameBuilder build ]
		raiseErrorWithMessageText:
		'The board must have at least 1000 parsecs.'
]

{ #category : 'tests' }
GameInteractionTest >> test001ifTheBoardHasLessThanOneSquareThenTheBoardIsNotValid [

	| gameBuilder |
	gameBuilder := GameBuilder new withSquares: 0.
	self
		should: [ gameBuilder build ]
		raiseErrorWithMessageText: 'The board must have at least 1 square.'
]

{ #category : 'tests' }
GameInteractionTest >> test002whenBoardIsCreatedWithLessThanTwoShipsThenIsNotValid [

	| gameBuilder |
	gameBuilder := GameBuilder new withSpaceships:
		               { (Spaceship withName: 'nave') }.

	self
		should: [ gameBuilder build ]
		raiseErrorWithMessageText: 'The board must have at least 2 ships.'
]

{ #category : 'tests' }
GameInteractionTest >> test003WhenLoadedWithOnlyOneDiceThenIsValid [

	| preloadedDice dicePool gameBuilder |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 2 4 ).
	dicePool := DicePool withDice: { preloadedDice }.

	gameBuilder := GameBuilder new withDicepool: dicePool.
	self shouldnt: [ gameBuilder build ] raise: Error
]

{ #category : 'tests' }
GameInteractionTest >> test004WhenLoadedWithACertainAmountOfDiceWithDifferentFacesThenIsValid [

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
GameInteractionTest >> test005BoardCreatesAlistOfShipsInPosition1 [

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
GameInteractionTest >> test006FirstPlayerShouldThrowDicesFirst [

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
GameInteractionTest >> test007SecondPlayerThrowsDice [

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
GameInteractionTest >> test008TwoPlayerPlaysTwoTimesEach [

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
GameInteractionTest >> test009theTurnRotatesAutomaticallyAfterPreviousPlayerThrewDices [

	| preloadedDice ships dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 2 ).
	ships := { 
		(Spaceship withName: 'One'). 
		(Spaceship withName: 'Two') 
	}.
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
	          withSpaceships: ships;
		       withDicepool: dicePool;
		       build.
   
   game throwDiceNextTurn.
	self assert: ((game spaceshipNamed: 'One') at: #position) equals: 3.
	self assert: ((game spaceshipNamed: 'Two') at: #position) equals: 1.
	
	game throwDiceNextTurn.
	self assert: ((game spaceshipNamed: 'One') at: #position) equals: 3.
	self assert: ((game spaceshipNamed: 'Two') at: #position) equals: 3.
	
	game throwDiceNextTurn.
	self assert: ((game spaceshipNamed: 'One') at: #position) equals: 5.
	self assert: ((game spaceshipNamed: 'Two') at: #position) equals: 3.
]

{ #category : 'tests' }
GameInteractionTest >> test010IfASpaceshipGoesBeyondTheLastSquareItWins [

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
GameInteractionTest >> test011WhenTheGameIsOverThenYouCantAskForNextTurn [

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
GameInteractionTest >> test012whenTheGameIsntOverThenYouCantAskForTheWinningShip [

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
GameInteractionTest >> test013whenYouAskForASpaceShipPositionThenYouGetAResponse [

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
GameInteractionTest >> test014whenYouAskForASpaceshipThatDoesNotExistThenYouDontGetPosotion [

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
GameInteractionTest >> test015whenYouPlayWithLapsThenTheGameContinuesWhenAPLayerGoesBeyondTheLastSquare [

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
GameInteractionTest >> test016whenYouPlayWithLapsThenTheGameCanLocateTheExactSpaceShipPosotion [

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
GameInteractionTest >> test017whenAPlayerReachsFinalLapThenTheGameIsOverAndThereAreNotMoreTurnsAllowed [

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
GameInteractionTest >> test018whenYouAskForTheSpaceShipCurrentLapYouGetAResponse [

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
GameInteractionTest >> test019playersCanUseMultiplePermanentCardsAtTheSameTime [

    | ships dice game deckMock cardsToPlay |
    deckMock := DeckMock withSequence: {
                    Speed new.
                    Overload new.}.

    dice := DicePool withDice: { (DiceMock withSides: 4 andSequence: #( 1 2 )) }.

    ships := { (Spaceship withName: 'Ship1') . (Spaceship withName: 'Ship2') }.

    game := GameBuilder new
                withDicepool: dice;
                withSpaceships: ships;
                withSquares: 20;
                withDeck: deckMock;
                build.
    
    cardsToPlay := { 
        (Speed new affectsShipWithName: 'Ship1').
        (Overload new affectsShipWithName: 'Ship2')
        } asOrderedCollection .

    game permanentCard: (cardsToPlay first) from: 'Ship1'.
    game permanentCard: (cardsToPlay last) from: 'Ship1'.

    game throwDiceNextTurn.
    game throwDiceNextTurn.

    self assert: ((game spaceshipNamed: 'Ship1') at:'position') equals: 3.
    self assert: ((game spaceshipNamed: 'Ship2') at:'position') equals: 1.
]

{ #category : 'tests' }
GameInteractionTest >> test020playersCannotUsePermanentCardsWhenItsNotTheirTurnInTheGame [
    | ships dice game deckMock cardsToPlay |
    deckMock := DeckMock withSequence: {
                    Speed new.
                    Overload new.}.

    dice := DicePool withDice: { (DiceMock withSides: 4 andSequence: #( 1 2 )) }.

    ships := { (Spaceship withName: 'Ship1') . (Spaceship withName: 'Ship2') }.

    game := GameBuilder new
                withDicepool: dice;
                withSpaceships: ships;
                withSquares: 20;
                withDeck: deckMock;
                build.
    
    cardsToPlay := Overload new affectsShipWithName: 'Ship1'.

    self 
        should: [ game permanentCard: cardsToPlay from: 'Ship2' ] 
        raiseErrorWithMessageText: 'The player must have a turn in the game to use a permanent card'
]
