Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardManager class >> withActiveCards: cards [

^self new initializeWithActiveCards: cards 
]

{ #category : 'initialization' }
CardManager >> addPermanentCard: card to: shipInTurn [

	activeCards add: (shipInTurn playCard: card)
]

{ #category : 'initialization' }
CardManager >> applyEffectOn: aShip overThrow: aThrow [

	| resultingThrow |
	resultingThrow := aThrow.

	activeCards do: [ :card |
		resultingThrow := card
			                  applyEffectOn: aShip
			                  overThrow: resultingThrow ].
	^ resultingThrow
]

{ #category : 'initialization' }
CardManager >> initializeWithActiveCards: _cards [

	super initialize.
	activeCards := _cards asOrderedCollection 
]
