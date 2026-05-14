Class {
	#name : 'BoardTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001 [

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
BoardTest >> test002 [

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
BoardTest >> test003 [

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
BoardTest >> test004 [

	| preloadedSquares board ship finalPosition |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
	board := preloadedSquares createBoard.
	ship := Spaceship withName: 'ship' andPosition: 2.

	finalPosition := Spaceship withName: 'ship' andPosition: 6.
	
	self assert: (board shipLandsOnSquare: ship) equals: finalPosition
]

{ #category : 'tests' }
BoardTest >> test005BoardUpdatesThePlayersPositionsInTurn [

	| preloadedSquares board ships updatedShips finalPositions |
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
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
