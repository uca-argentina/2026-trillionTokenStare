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

{ #category : 'comparing' }
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
Redo >> initialize [

	super initialize.
	^ self
]

{ #category : 'comparing' }
Redo >> redoCardWithShipThatReceivesEffect: _shipThatReceivesEffect orCardToCancel: _cardToCancel andGame: aGame [

	aGame
		repeatCardEffectForShipNamed: _shipThatReceivesEffect
		orCardToCancel: _cardToCancel
]

{ #category : 'comparing' }
Redo >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]
