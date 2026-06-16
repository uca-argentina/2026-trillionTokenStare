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

{ #category : 'behavior' }
CardManager >> addPermanentCard: card from: shipInTurn [

	| lastCardPlayed |
	lastCardPlayed := shipInTurn playCard: card.

	activeCards add: lastCardPlayed.

]

{ #category : 'behavior' }
CardManager >> addPermanentCardDirectly: card [

	activeCards add: card.
	
]

{ #category : 'behavior' }
CardManager >> applyPermanentEffectOnShip: aShip overThrow: aThrow [

	| resultingThrow |
	resultingThrow := aThrow.

	activeCards do: [ :card |
			resultingThrow := card
				                  applyPermanentEffectOnShip: aShip
				                  overThrow: resultingThrow ].
	^ resultingThrow
]

{ #category : 'behavior' }
CardManager >> cancel: card [

	activeCards remove: card ifAbsent: [ self error: 'Impossible to cancel a card that is not active' ]
]

{ #category : 'initialization' }
CardManager >> initializeWithActiveCards: _cards [

	super initialize.
	activeCards := _cards asOrderedCollection 
]

{ #category : 'accessing' }
CardManager >> permanentCards [

	^ activeCards
]
