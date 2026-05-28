Class {
	#name : 'Speed',
	#superclass : 'Card',
	#instVars : [
		'shipToAffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Speed >> = aCard [

	^ self class = aCard class
]

{ #category : 'initialization' }
Speed >> affectsShipWithName: _shipToAffect [

	shipToAffect := _shipToAffect.
	^ self
]

{ #category : 'initialization' }
Speed >> applyEffectOn: aShip overThrow: aThrow [

	aShip name = shipToAffect ifTrue: [ ^ aThrow + 1 ].
	^ aThrow
]

{ #category : 'initialization' }
Speed >> initialize [

	super initialize.
	shipToAffect := ''.
	^ self
]
