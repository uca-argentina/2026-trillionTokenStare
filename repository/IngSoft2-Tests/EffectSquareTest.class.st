Class {
	#name : 'EffectSquareTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectSquareTest >> test001WhenSpaceshipLandsOnNormalSquareNoEffectIsApplied [

	| noEffectSquare aShip updatedShip|
	noEffectSquare := Square new.
	aShip := Spaceship withName: 'spaceship' andPosition: 5.
	updatedShip := aShip landsOn: noEffectSquare. 
	
	self assert: updatedShip position equals: 5.
	
]

{ #category : 'tests' }
EffectSquareTest >> test002WhenSpaceshipLandsOnWormholeThenMovesBack4Squares [

	| wormholeSquare aShip updatedShip|
	wormholeSquare := Wormhole new.
	aShip := Spaceship withName: 'spaceship' andPosition: 5.
	updatedShip := aShip landsOn: wormholeSquare. 
	
	self assert: updatedShip position equals: 1.
	
]

{ #category : 'tests' }
EffectSquareTest >> test003WhenSpaceshipLandsOnSpeedUpSquareThenMovesForward4Squares [

	| speedUpSquare aShip updatedShip|
	speedUpSquare := Speedup new.
	aShip := Spaceship withName: 'spaceship' andPosition: 5.
	updatedShip := aShip landsOn: speedUpSquare. 
	
	self assert: updatedShip position equals: 9.
	
]

{ #category : 'tests' }
EffectSquareTest >> test004effectPool [

	| mockEffectPool squareList |
	'
		Algo que deberia hacer es un effect pool que no sea mock, 
		que le paso una lista de casillas con una probabilidad y 
		--> createBoard retorne la lista con la probabilidad correcta
	'.
	mockEffectPool := MockSquarePool withPreloadedSquares: {
			                  Speedup.
			                  Square.
			                  Square.
			                  Square.
			                  Square.
			                  Wormhole.
			                  Square }.
	squareList := mockEffectPool createBoard.

	self deny: true
]

{ #category : 'tests' }
EffectSquareTest >> test005GameLoadedWithOneWormholeWorksAsEspected [

	| preloadedDice preloadedSquares dicePool board finalPositions |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 2 3 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Wormhole }.
	board := Board
		         usingSquares: preloadedSquares
		         andShips: 2
		         andDicePool: dicePool.

	1 to: 3 do: [ :turn | board nextTurn ].

	finalPositions := {
		                  (Spaceship withName: 1 andPosition: 2).
		                  (Spaceship withName: 2 andPosition: 4) }
		                  asOrderedCollection.

	self assert: board ships equals: finalPositions
]

{ #category : 'tests' }
EffectSquareTest >> test006GameLoadedWithOneSpeedUpWorksAsEspected [

	| preloadedDice preloadedSquares dicePool board finalPositions |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 1 3 ).
	dicePool := DicePool withDice: { preloadedDice }.
	preloadedSquares := MockSquarePool withPreloadedSquares: {
			                    Square.
			                    Speedup.
			                    Square.
			                    Square.
			                    Square.
			                    Square.
			                    Square }.
	board := Board
		         usingSquares: preloadedSquares
		         andShips: 2
		         andDicePool: dicePool.

	1 to: 2 do: [ :turn | board nextTurn ].

	finalPositions := {
		                  (Spaceship withName: 1 andPosition: 6).
		                  (Spaceship withName: 2 andPosition: 4) }
		                  asOrderedCollection.

	self assert: board ships equals: finalPositions
]
