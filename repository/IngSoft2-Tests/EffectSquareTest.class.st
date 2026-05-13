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
