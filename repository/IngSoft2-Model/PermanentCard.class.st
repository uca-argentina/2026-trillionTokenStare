Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
PermanentCard >> = aCard [

	^ self class = aCard class
]

{ #category : 'initialization' }
PermanentCard >> affectsShipWithName: _shipToAffect [

	^ self
]

{ #category : 'behavior' }
PermanentCard >> redoCardWithShipThatReceivesEffect: shipThatReceivesEffect orCardToCancel: cardToCancel andGame: aGame [

	^ aGame addPermanentCardDirectly:
		  (self class new affectsShipWithName: shipThatReceivesEffect)
]
