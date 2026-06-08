Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
Cancellation >> applyInstantEffect [

	cardManager cancel: cardToCancel
]

{ #category : 'initialization' }
Cancellation >> initialize [

	super initialize.
	cardToCancel := Card new.
	cardManager:= CardManager withActiveCards: {  }.
	^ self
]

{ #category : 'initialization' }
Cancellation >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]
