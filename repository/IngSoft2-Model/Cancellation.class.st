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

	aGame cancelCard: cardToCancel.
	aGame setLastPlayedCard: self
]

{ #category : 'validation' }
Cancellation >> validateIfCanBeDrawnOnGame: aGame [

	aGame activeCards isEmpty ifTrue: [
			self error:
				'Unable to use Cantellation card if no active cards are in game.' ]
]

{ #category : 'initialization' }
Cancellation >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]
