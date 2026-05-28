Class {
	#name : 'BoardTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001SquarePoolCreatesABoardWhenAskedTo [

	| mockBoard board |
	mockBoard := MockBoardBuilder new.
	board := mockBoard build.

	self assert: (board isMemberOf: Board)
]

{ #category : 'tests' }
BoardTest >> test002BoardConfirmsASpaceshipIsOutside [

	| preloadedSquares board ship |
	preloadedSquares := MockBoardBuilder new.
	board := preloadedSquares build.
	ship := Spaceship withName: 'ship' andPosition: 11.


	self deny: (board shipInsideBoard: ship)
]

{ #category : 'tests' }
BoardTest >> test003BoardConfirmsASpaceshipIsInside [

	| preloadedSquares board ship |
	preloadedSquares := MockBoardBuilder new.
	board := preloadedSquares build.
	ship := Spaceship withName: 'ship' andPosition: 10.


	self assert: (board shipInsideBoard: ship)
]

{ #category : 'tests' }
BoardTest >> test005BoardUpdatesThePlayersPositionsInTurn [

	| preloadedSquares board ships updatedShips finalPositions |
	preloadedSquares := MockBoardBuilder new.
	board := preloadedSquares build.
	ships := {
		         (Spaceship withName: '1' andPosition: 1).
		         (Spaceship withName: '2' andPosition: 3) }.


	updatedShips := board shipInTurn: 1 movesForward: 2 andAffects: ships.

	finalPositions := {
		                  (Spaceship withName: '1' andPosition: 3).
		                  (Spaceship withName: '2' andPosition: 3) }.


	self assert: updatedShips equals: finalPositions 
]

{ #category : 'tests' }
BoardTest >> test006BoardExecutesSpeedUpActionOnSpaceShip [

	| preloadedSquares board ships updatedShips finalPositions |
	preloadedSquares := MockBoardBuilder new withEffects: {
			                    Square new.
			                    Speedup new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    Square new }.
	board := preloadedSquares build.
	ships := {
		         (Spaceship withName: '1' andPosition: 1).
		         (Spaceship withName: '2' andPosition: 3) }.


	updatedShips := board shipInTurn: 1 movesForward: 1 andAffects: ships.

	finalPositions := {
		                  (Spaceship withName: '1' andPosition: 6).
		                  (Spaceship withName: '2' andPosition: 3) }.


	self assert: updatedShips equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test007BoardExecutesWormholeActionOnSpaceShip [

	| preloadedSquares board ships updatedShips finalPositions |
	preloadedSquares := MockBoardBuilder new withEffects: {
			                    Square new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    Wormhole new}.
	board := preloadedSquares build.
	ships := {
		         (Spaceship withName: '1' andPosition: 5).
		         (Spaceship withName: '2' andPosition: 3) }.


	updatedShips := board shipInTurn: 1 movesForward: 1 andAffects: ships.

	finalPositions := {
		                  (Spaceship withName: '1' andPosition: 2).
		                  (Spaceship withName: '2' andPosition: 3) }.


	self assert: updatedShips equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test008BoardExecutesMoonwalkActionOnSpaceShip [

	| preloadedSquares board ships updatedShips finalPositions |
	preloadedSquares := MockBoardBuilder new withEffects: {
			                    Square new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    Moonwalk new.
			                    Square new }.
	board := preloadedSquares build.
	ships := {
		         (Spaceship withName: '1' andPosition: 4).
		         (Spaceship withName: '2' andPosition: 4).
		         (Spaceship withName: '3' andPosition: 4) }.


	updatedShips := board shipInTurn: 1 movesForward: 1 andAffects: ships.

	finalPositions := {
		                  (Spaceship withName: '1' andPosition: 5).
		                  (Spaceship withName: '2' andPosition: 1).
		                  (Spaceship withName: '3' andPosition: 1) }.


	self assert: updatedShips equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test009BoardExecutesAtomicBombActionOnSpaceShip [

	| preloadedSquares board ships updatedShips finalPositions |
	preloadedSquares := MockBoardBuilder new withEffects: {
			                    Square new.
			                    Square new.
			                    Square new.
			                    Square new.
			                    AtomicBomb new.
			                    Square new}.
	board := preloadedSquares build.
	ships := {
		         (Spaceship withName: '1' andPosition: 4).
		         (Spaceship withName: '2' andPosition: 4).
		         (Spaceship withName: '3' andPosition: 4) }.


	updatedShips := board shipInTurn: 1 movesForward: 1 andAffects: ships.

	finalPositions := {
		                  (Spaceship withName: '1' andPosition: 1).
		                  (Spaceship withName: '2' andPosition: 1).
		                  (Spaceship withName: '3' andPosition: 1) }.


	self assert: updatedShips equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test010HyperJumpSquareWithParsecs [

	| finalPositions ships boardBuilder game hyperJumpSquare |
	hyperJumpSquare := HyperJump new withJumpsInParsecs: { 300 . 200 }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                hyperJumpSquare.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.
	finalPositions := {
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 1 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 5 } } }.


	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' ) in: game afterTurns: 3)
		equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test011GameRunnsWithAllTheSpecialEffectSquares [

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
BoardTest >> test012BoardDistribution [

	| numberOfSquares distributedBoard |
	numberOfSquares := 100.


	distributedBoard := BoardBuilder new
		                    withSquares: numberOfSquares;
		                    build.

	self assert: distributedBoard size equals: 100.
	self assert: (distributedBoard occurrencesOf: Square) equals: 40.
	self assert: (distributedBoard occurrencesOf: Wormhole) equals: 20.
	self assert: (distributedBoard occurrencesOf: Speedup) equals: 20.
	self assert: (distributedBoard occurrencesOf: Moonwalk) equals: 10.
	self assert: (distributedBoard occurrencesOf: HyperJump) equals: 8.
	self assert: (distributedBoard occurrencesOf: AtomicBomb) equals: 2
]

{ #category : 'tests' }
BoardTest >> test013WhenAShipIsMovedByAnEffectOntoAnotherEffectSquareTheSecondEffectIsNotTriggered [

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

	game nextTurn.
	positionsExpected := {
		                     { 'one'. 6 }.
		                     { 'two'. 1 } }.
	self
		assert: (self positionOf: #( 'one' 'two' ) in: game)
		equals: positionsExpected
]

{ #category : 'tests' }
BoardTest >> test014RandomMoonwalksHaveVaryingBacktracks [
        | moonwalks backtracks |
        moonwalks := (1 to: 100) collect: [ :i |
                Moonwalk new atPosition: i; withParsecs: 100; withBacktrack: (2 to: 6) atRandom. ].
        backtracks := (moonwalks collect: [ :m | m backtrack ]) asSet.
        self assert: backtracks size > 1
]

{ #category : 'tests' }
BoardTest >> test015HyperJumpAppliesJumpsFromHighestToLowestEvenWhenInputListIsUnsorted [

	| finalPositions boardBuilder game ships |
	
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.
		
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                HyperJump new withJumpsInParsecs: {100 . 300 . 200}.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.
		
	finalPositions := {
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 1 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 3 } } }.


	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' ) in: game afterTurns: 3)
		equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test016HyperJumpLoopsWhenTItRunsOurOfJumps [

	| finalPositions boardBuilder game ships |
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three').
		         (Spaceship withName: 'four') }.

	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                (HyperJump new withJumpsInParsecs: { 300. 200. 100 }).
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.

	finalPositions := {
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 1 }.
			                  { 'three'. 1 }.
			                  { 'four'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 1 }.
			                  { 'four'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 3 }.
			                  { 'four'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 3 }.
			                  { 'four'. 5 } } }.


	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' 'four' ) in: game afterTurns: 4)
		equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test017WhenSquaresAreNotContiguousToEachOtherInItsPositionThenIsNotValid [

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
BoardTest >> test018WhenTheFirstSquarePositionIsNotOneThenIsNotValid [

	| squareList |
	squareList := {
		              (Square new atPosition: 3).
		              (Square new atPosition: 4) }.

	self
		should: [ Board withSquares: squareList andLaps: 1 ]
		raiseErrorWithMessageText: 'First square position must be 1'
]

{ #category : 'tests' }
BoardTest >> test019HyperJumpSquareWithLightYears [

	| finalPositions ships boardBuilder game hyperJumpSquare |
	hyperJumpSquare := HyperJump new withJumpsInLightYears: { 101. 67 }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                hyperJumpSquare.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	game := GameBuilder new
		        withLightYears: 334;
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.
	finalPositions := {
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 1 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 5 } } }.


	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' ) in: game afterTurns: 3)
		equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test020WhenParsecsBetweenSquaresAreNotUniformThenIsNotValid [

	| squareList |
	squareList := {
		              (Square new atPosition: 1; withParsecs: 50).
		              (Square new atPosition: 2; withParsecs: 30) }.


	self
		should: [ Board withSquares: squareList andLaps: 1 ]
		raiseErrorWithMessageText:
		'Squares are required to all have the same amount of parsecs'
]
