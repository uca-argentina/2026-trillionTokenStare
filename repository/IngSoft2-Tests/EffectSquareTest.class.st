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
