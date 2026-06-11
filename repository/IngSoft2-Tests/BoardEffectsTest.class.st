Class {
	#name : 'BoardEffectsTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardEffectsTest >> test001SquarePoolCreatesABoardWhenAskedTo [

	| mockBoard board |
	mockBoard := MockBoardBuilder new.
	board := mockBoard build.

	self assert: (board isMemberOf: Board)
]

{ #category : 'tests' }
BoardEffectsTest >> test002BoardConfirmsASpaceshipIsOutside [

	| preloadedSquares board ship |
	preloadedSquares := MockBoardBuilder new.
	board := preloadedSquares build.
	ship := (Spaceship withName: 'ship' ) movesForward: 10.


	self deny: (board shipInsideBoard: ship)
]

{ #category : 'tests' }
BoardEffectsTest >> test003BoardConfirmsASpaceshipIsInside [

	| preloadedSquares board ship |
	preloadedSquares := MockBoardBuilder new.
	board := preloadedSquares build.
	ship := (Spaceship withName: 'ship') movesForward: 9.


	self assert: (board shipInsideBoard: ship)
]

{ #category : 'tests' }
BoardEffectsTest >> test006BoardExecutesSpeedUpActionOnSpaceShip [

	| preloadedDice dicePool game listOfShips boardBuilder |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                Speedup new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.
	game := GameBuilder new
		        withDicepool: dicePool;
		        withBoardBuilder: boardBuilder;
		        build.

	game throwDiceNextTurn.

	listOfShips := {
		               { 'one'. 6 }.
		               { 'two'. 1 } }.

	self
		assert: (self positionOf: #( 'one' 'two' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
BoardEffectsTest >> test007BoardExecutesWormholeActionOnSpaceShip [

	| preloadedDice dicePool game listOfShips boardBuilder |
	preloadedDice := DiceMock withSides: 6 andSequence: #( 5 ).
	dicePool := DicePool withDice: { preloadedDice }.
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Wormhole new }.
	game := GameBuilder new
		        withDicepool: dicePool;
		        withBoardBuilder: boardBuilder;
		        build.

	game throwDiceNextTurn.

	listOfShips := {
		               { 'one'. 2 }.
		               { 'two'. 1 } }.

	self
		assert: (self positionOf: #( 'one' 'two' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
BoardEffectsTest >> test009BoardExecutesAtomicBombActionOnSpaceShip [

	| preloadedDice dicePool game listOfShips boardBuilder ships |
	preloadedDice := DiceMock withSides: 6 andSequence: #( 4 4 5 ).
	dicePool := DicePool withDice: { preloadedDice }.
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                AtomicBomb new.
			                Square new }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.

	game := GameBuilder new
		        withDicepool: dicePool;
		        withBoardBuilder: boardBuilder;
		        withSpaceships: ships;
		        build.

	game throwDiceNextTurn.
	game throwDiceNextTurn.
	game throwDiceNextTurn.

	listOfShips := {
		               { 'one'. 1 }.
		               { 'two'. 1 }.
		               { 'three'. 1 } }.

	self
		assert: (self positionOf: #( 'one' 'two' 'three' ) in: game)
		equals: listOfShips 
]

{ #category : 'tests' }
BoardEffectsTest >> test011GameRunnsWithAllTheSpecialEffectSquares [

	| mockBoardBuilder game preloadedDicePool allTurnsResults |
	mockBoardBuilder := MockBoardBuilder new withEffects: {
			                    Square new.
			                    Speedup new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    HyperJump new.
			                    Wormhole new.
			                    Square new.
			                    Square new.
			                    Moonwalk new.
			                    AtomicBomb new}.
	preloadedDicePool := DicePool withDice:
		                     { (DiceMock
			                      withSides: 10
			                      andSequence: #( 1 3 2 3 7 7 )) }.

	game := GameBuilder new
		        withBoardBuilder: mockBoardBuilder;
		        withDicepool: preloadedDicePool;
		        withParsecs: 2000;
		        build.


	allTurnsResults := {
		                   {
			                   { 'one'. 6 }.
			                   { 'two'. 1 } }.
		                   {
			                   { 'one'. 6 }.
			                   { 'two'. 4 } }.
		                   {
			                   { 'one'. 4 }.
			                   { 'two'. 4 } }.
		                   {
			                   { 'one'. 4 }.
			                   { 'two'. 8 } }.
		                   {
			                   { 'one'. 11 }.
			                   { 'two'. 5 } }.
		                   {
			                   { 'one'. 1 }.
			                   { 'two'. 1 } } }.
	self
		assert: (self positionOf: #( 'one' 'two' ) in: game afterTurns: 6)
		equals: allTurnsResults
]

{ #category : 'tests' }
BoardEffectsTest >> test013WhenAShipIsMovedByAnEffectOntoAnotherEffectSquareTheSecondEffectIsNotTriggered [

	| preloadedSquares game preloadedDicePool positionsExpected |
	preloadedSquares := MockBoardBuilder new withEffects: {
			                    Square new.
			                    Speedup new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    Wormhole new}.
	preloadedDicePool := DicePool withDice:
		                     { (DiceMock withSides: 4 andSequence: #( 1 )) }.
	game := GameBuilder new
		        withBoardBuilder: preloadedSquares;
		        withDicepool: preloadedDicePool;
		        build.

	game throwDiceNextTurn.
	positionsExpected := {
		                     { 'one'. 6 }.
		                     { 'two'. 1 } }.
	self
		assert: (self positionOf: #( 'one' 'two' ) in: game)
		equals: positionsExpected
]

{ #category : 'tests' }
BoardEffectsTest >> test017WhenSquaresAreNotContiguousToEachOtherInItsPositionThenIsNotValid [

	| squareList |
	squareList := {
		              (Square new atPosition: 1).
		              (Square new atPosition: 3) }.


	self
		should: [ Board withSquares: squareList andLaps: 1 ]
		raiseErrorWithMessageText:
		'Squares are required to be contiguous to each other'
]

{ #category : 'tests' }
BoardEffectsTest >> test018WhenTheFirstSquarePositionIsNotOneThenIsNotValid [

	| squareList |
	squareList := {
		              (Square new atPosition: 3).
		              (Square new atPosition: 4) }.

	self
		should: [ Board withSquares: squareList andLaps: 1 ]
		raiseErrorWithMessageText: 'First square position must be 1'
]

{ #category : 'tests' }
BoardEffectsTest >> test019whenAPlayerReachTheAtomicBombSquareThenAllPlayersReturnToTheFirstSquareWithoutLoosingAnyLaps [

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
BoardEffectsTest >> test020WhenParsecsBetweenSquaresAreNotUniformThenIsNotValid [

	| squareList |
	squareList := {
		              (Square new atPosition: 1; withParsecs: 50).
		              (Square new atPosition: 2; withParsecs: 30) }.


	self
		should: [ Board withSquares: squareList andLaps: 1 ]
		raiseErrorWithMessageText:
		'Squares are required to all have the same amount of parsecs'
]
