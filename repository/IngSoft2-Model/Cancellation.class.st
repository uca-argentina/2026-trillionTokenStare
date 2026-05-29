Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Cancellation >> affectsCard: aCard [

	cardToCancel := aCard.
	^ self
]

{ #category : 'initialization' }
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
