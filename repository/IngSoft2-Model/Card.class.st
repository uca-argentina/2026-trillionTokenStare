Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Card >> = aCard [

	^ self class = aCard class
]

{ #category : 'behavior' }
Card >> applyInstantEffectOnGame: aGame [
	self error: 'Not an instant effect card'
]

{ #category : 'behavior' }
Card >> applyPermanentEffectOnShip: aShip overThrow: aThrow [

	self error: 'Not a permanent effect card.'
]

{ #category : 'behavior' }
Card >> redoCardWithShipThatReceivesEffect: _shipThatReceivesEffect orCardToCancel: _cardToCancel andGame: aGame [

self error: 'To use (Redo Card) firts a player needs to use a card.'
]

{ #category : 'validation' }
Card >> validateIfCanBeDrawnOnGame: aGame [

	
]
