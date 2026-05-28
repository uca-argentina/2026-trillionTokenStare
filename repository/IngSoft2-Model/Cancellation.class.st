Class {
	#name : 'Cancellation',
	#superclass : 'Card',
	#instVars : [
		'cardToCancel',
		'cardManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Cancellation >> = aCard [

	^ self class = aCard class
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

{ #category : 'initialization' }
Cancellation >> withCardManager: _cardManager [ 

cardManager := _cardManager 
]

{ #category : 'initialization' }
Cancellation >> withCardToCancel: _cardToCancel [

	cardToCancel := _cardToCancel
]
