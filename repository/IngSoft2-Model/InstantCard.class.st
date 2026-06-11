Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
InstantCard >> affectsShipWithName: _target [

	^ self
]

{ #category : 'behavior' }
InstantCard >> redoCardWithShipThatReceivesEffect: shipThatReceivesEffect orCardToCancel: cardToCancel andGame: aGame [

	self
		affectsShipWithName: shipThatReceivesEffect;
		withCardToCancel: cardToCancel;
		applyInstantEffectOnGame: aGame
]

{ #category : 'initialization' }
InstantCard >> withCardToCancel: aCard [

	^ self
]
