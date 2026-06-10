Class {
	#name : 'Speed',
	#superclass : 'PermanentCard',
	#instVars : [
		'shipToAffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Speed >> affectsShipWithName: _shipToAffect [

	shipToAffect := _shipToAffect.
	^ self
]

{ #category : 'initialization' }
Speed >> applyPermanentEffectOnShip: aShip overThrow: aThrow [

	aShip name = shipToAffect ifTrue: [ ^ aThrow + 1 ].
	^ aThrow
]
