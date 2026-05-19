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
	board := preloadedSquares createBoard.
	
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
	board := preloadedSquares createBoard.
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
	board := preloadedSquares createBoard.
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
	board := preloadedSquares createBoard.
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
	board := preloadedSquares createBoard.
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
	board := preloadedSquares createBoard.
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
	board := preloadedSquares createBoard.
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
	board := preloadedSquares createBoard.
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
	square := HyperJump
		          defaultAt: 2
		          andJumps: { 300 . 200 }
		          andParsecsToSquares: 0.01.
	ship1 := Spaceship withName: 1 andPosition: 2.
	ship2 := Spaceship withName: 2 andPosition: 2.
	ship3 := Spaceship withName: 3 andPosition: 2.
	finalPositions := {
		                  (Spaceship withName: 1 andPosition: 5).
		                  (Spaceship withName: 2 andPosition: 4).
		                  (Spaceship withName: 3 andPosition: 5) }.

	updatedPositions := {
		                    (square applyEffectTo: ship1).
		                    (square applyEffectTo: ship2).
		                    (square applyEffectTo: ship3) }.

	self assert: updatedPositions equals: finalPositions
]

{ #category : 'tests' }
BoardTest >> test011BoardExecutesHyperJumpActionOnSpaceShip [

	| preloadedSquares finalPositions preloadedDice dicePool game |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 ).
	dicePool := DicePool withDice: { preloadedDice }.
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    HyperJump.
			                    Square.
			                    Square.
			                    Square.
			                    Square }.
	game := Game
		        withSquarePool: preloadedSquares
		        andShips: 3
		        andDicePool: dicePool.


	1 to: 3 do: [ :turn | game nextTurn ].

	finalPositions := {
		                  (Spaceship withName: 1 andPosition: 5).
		                  (Spaceship withName: 2 andPosition: 4).
		                  (Spaceship withName: 3 andPosition: 5) }.



	self assert: game ships equals: finalPositions asOrderedCollection
]
