Class {
	#name : 'Overload',
	#superclass : 'PermanentCard',
	#instVars : [
		'shipToAffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Overload >> affectsShipWithName: _shipToAffect [

	shipToAffect := _shipToAffect.
	^ self
]

{ #category : 'as yet unclassified' }
Overload >> applyPermanentEffectOnShip: aShip overThrow: aThrow [

	aShip name = shipToAffect ifTrue: [ ^ aThrow - 2 max: 1 ].
	^ aThrow
]
