Class {
	#name : 'Overload',
	#superclass : 'Card',
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
Overload >> applyEffectOn: aShip overThrow: aThrow [

	aShip name = shipToAffect ifTrue: [ ^ aThrow - 2 max: 1 ].
	^ aThrow
]

{ #category : 'initialization' }
Overload >> initialize [

	super initialize.
	shipToAffect := ''.
	^ self
]
