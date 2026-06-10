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

	aGame lastCardPlayed
		redoCardWithShipThatReceivesEffect: shipThatReceivesEffect
		orCardToCancel: cardToCancel
		andGame: aGame
]

{ #category : 'initialization' }
Redo >> initialize [

	super initialize.
	^ self
]

{ #category : 'comparing' }
Redo >> redoCardWithShipThatReceivesEffect: _shipThatReceivesEffect orCardToCancel: _cardToCancel andGame: aGame [

	aGame lastCardPlayed
		affectsShipWithName: _shipThatReceivesEffect;
		withCardToCancel: _cardToCancel;
		applyInstantEffectOnGame: aGame
]

{ #category : 'comparing' }
Redo >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]
