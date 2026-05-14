Class {
	#name : 'EffectSquareTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectSquareTest >> test001WhenSpaceshipLandsOnNormalSquareNoEffectIsApplied [

	| noEffectSquare aShip updatedShip|
	noEffectSquare := Square defaultAt: 1 .
	aShip := Spaceship withName: 'spaceship' andPosition: 5.
	updatedShip := aShip landsOn: noEffectSquare. 
	
	self assert: updatedShip position equals: 5.
	
]

{ #category : 'tests' }
EffectSquareTest >> test002WhenSpaceshipLandsOnWormholeThenMovesBack4Squares [

	| wormholeSquare aShip updatedShip|
	wormholeSquare := Wormhole defaultAt:5 .
	aShip := Spaceship withName: 'spaceship' andPosition: 5.
	updatedShip := aShip landsOn: wormholeSquare. 
	
	self assert: updatedShip position equals: 1.
	
]

{ #category : 'tests' }
EffectSquareTest >> test003WhenSpaceshipLandsOnSpeedUpSquareThenMovesForward4Squares [

	| speedUpSquare aShip updatedShip|
	speedUpSquare := Speedup defaultAt:5 .
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
