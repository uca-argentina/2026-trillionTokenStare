Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
InstantCard >> = aCard [

	^ self class = aCard class
]

{ #category : 'comparing' }
InstantCard >> affectsShipWithName: _target [

	^ self
]

{ #category : 'comparing' }
InstantCard >> redoCardWithShipThatReceivesEffect: shipThatReceivesEffect orCardToCancel: cardToCancel andGame: aGame [

	self
		affectsShipWithName: shipThatReceivesEffect;
		withCardToCancel: cardToCancel;
		applyInstantEffectOnGame: aGame
]

{ #category : 'comparing' }
InstantCard >> withCardToCancel: aCard [

	^ self
]
