Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
Cancellation >> applyInstantEffectOnGame: aGame [

	aGame cards cancel: cardToCancel
]

{ #category : 'initialization' }
Cancellation >> initialize [

	super initialize.
	^ self
]

{ #category : 'initialization' }
Cancellation >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]
