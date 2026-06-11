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

{ #category : 'comparing' }
PermanentCard >> affectsShipWithName: _shipToAffect [

	^ self
]

{ #category : 'comparing' }
PermanentCard >> redoCardWithShipThatReceivesEffect: shipThatReceivesEffect orCardToCancel: cardToCancel andGame: aGame [
	
	aGame addPermanentCard: (self affectsShipWithName: shipThatReceivesEffect)
	"aGame cards
		addPermanentCard: (self affectsShipWithName: shipThatReceivesEffect)
		from: aGame ships shipInTurn"
]

{ #category : 'comparing' }
PermanentCard >> setAsLastPlayedCardOnGame: aGame [

	aGame setLastPlayedCard: self
]
