Class {
	#name : 'BoardTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001SquarePoolCreatesABoardWhenAskedTo [

	| preloadedSquares board |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.

	self assert: (board isMemberOf: Board)
]

{ #category : 'tests' }
BoardTest >> test002BoardConfirmsASpaceshipIsOutside [

	| preloadedSquares board ship |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.
	ship:= Spaceship withName: 'ship' andPosition: 7.
	
	
	self deny: (board shipInsideBoard: ship)
]

{ #category : 'tests' }
BoardTest >> test003BoardConfirmsASpaceshipIsInside [

	| preloadedSquares board ship |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.
	ship:= Spaceship withName: 'ship' andPosition: 6.

	
	self assert: (board shipInsideBoard: ship)
]

{ #category : 'tests' }
BoardTest >> test005BoardUpdatesThePlayersPositionsInTurn [

	| preloadedSquares board ships updatedShips finalPositions |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Square }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.
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
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Square }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.
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
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.
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
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Moonwalk .
			                    Square }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.
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
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    AtomicBomb.
			                    Square }.
	board := preloadedSquares createBoardWithLaps: 1 andParsecs: 1000.
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
BoardTest >> test010HyperJumpSquare [

	| square ship1 ship2 ship3 updatedPositions finalPositions |
	ship1 := Spaceship withName: 1 andPosition: 2.
	ship2 := Spaceship withName: 2 andPosition: 2.
	ship3 := Spaceship withName: 3 andPosition: 2.
	finalPositions := {
		                  (Spaceship withName: 1 andPosition: 5).
		                  (Spaceship withName: 2 andPosition: 4).
		                  (Spaceship withName: 3 andPosition: 5) }.
	square := HyperJump
                defaultAt: 2
                andJumps: { 150 . 100 }
                andParsecs: 50.

	updatedPositions := {
		                    (square applyEffectTo: ship1 in: nil).
		                    (square applyEffectTo: ship2 in: nil).
		                    (square applyEffectTo: ship3 in: nil) }.

	self assert: updatedPositions equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test011GameRunnsWithAllTheSpecialEffectSquares [

	| preloadedSquares game preloadedDicePool allTurnsResults |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    HyperJump.
			                    Wormhole.
			                    Square.
			                    Square.
			                    Moonwalk.
			                    AtomicBomb }.
	preloadedDicePool := DicePool withDice:
		                     { (DiceMock
			                      withSides: 10
			                      andSequence: #( 1 3 2 3 7 7 )) }.

	game := GameBuilder new
		        withSquarepool: preloadedSquares;
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

	| distributedSquarePool numberOfSquares distributedBoard |
	numberOfSquares := 100.
	distributedSquarePool := SquarePool defaultProbabilitiesWithSize: numberOfSquares.

	distributedBoard := distributedSquarePool createBoardWithLaps: 1 andParsecs: 1000.

	self assert: distributedBoard size equals: 100.
	self assert: (distributedBoard occurrencesOf: Square) equals: 40.
	self assert: (distributedBoard occurrencesOf: Wormhole) equals: 20.
	self assert: (distributedBoard occurrencesOf: Speedup) equals: 20.
	self assert: (distributedBoard occurrencesOf: Moonwalk) equals: 10.
	self assert: (distributedBoard occurrencesOf: HyperJump) equals: 8.
	self assert: (distributedBoard occurrencesOf: AtomicBomb ) equals: 2
]

{ #category : 'tests' }
BoardTest >> test013WhenAShipIsMovedByAnEffectOntoAnotherEffectSquareTheSecondEffectIsNotTriggered [

	| preloadedSquares game preloadedDicePool positionsExpected |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
	preloadedDicePool := DicePool withDice:
		                     { (DiceMock withSides: 4 andSequence: #( 1 )) }.
	game := GameBuilder new
		        withSquarepool: preloadedSquares;
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
                Moonwalk randomAt: i andParsecs: 100 ].
        backtracks := (moonwalks collect: [ :m | m backtrack ]) asSet.
        self assert: backtracks size > 1
]

{ #category : 'tests' }
BoardTest >> test015HyperJumpAppliesJumpsFromHighestToLowestEvenWhenInputListIsUnsorted [
        | hyperJump ship updatedShip |
        hyperJump := HyperJump
                defaultAt: 2
                andJumps: { 100. 300. 200 }
                andParsecs: 50.
        ship := Spaceship withName: 1 andPosition: 2.
        updatedShip := hyperJump applyEffectTo: ship in: nil.
        self assert: updatedShip position equals: 8
]

{ #category : 'tests' }
BoardTest >> test016HyperJumpResetsToHighestAfterExhaustingTheJumpList [

	| hyperJump ship1 ship2 ship3 ship4 results |
	hyperJump := HyperJump
		             defaultAt: 2
		             andJumps: { 300. 200. 100 }
		             andParsecs: 50.
	ship1 := Spaceship withName: 1 andPosition: 2.
	ship2 := Spaceship withName: 2 andPosition: 2.
	ship3 := Spaceship withName: 3 andPosition: 2.
	ship4 := Spaceship withName: 4 andPosition: 2.
	results := {
		           (hyperJump applyEffectTo: ship1 in: nil) position.
		           (hyperJump applyEffectTo: ship2 in: nil) position.
		           (hyperJump applyEffectTo: ship3 in: nil) position.
		           (hyperJump applyEffectTo: ship4 in: nil) position }.
	self assert: results equals: #( 8 6 4 8 )
]
