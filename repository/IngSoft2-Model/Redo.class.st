Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#instVars : [
		'shipThatReceivesEffect',
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Redo >> affectsShipWithName: _target [

	shipThatReceivesEffect := _target.
	^ self
]

{ #category : 'behavior' }
Redo >> applyInstantEffectOnGame: aGame [

	aGame
		repeatCardEffectForShipNamed: shipThatReceivesEffect
		orCardToCancel: cardToCancel
]

{ #category : 'initialization' }
Redo >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]
