Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'activeCards',
		'instantCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardManager class >> withActiveCards: cards [

^self new initializeWithActiveCards: cards 
]

{ #category : 'accessing' }
CardManager >> addPermanentCard: card from: shipInTurn [

	| lastCardPlayed |
	lastCardPlayed := shipInTurn playCard: card.

	activeCards add: lastCardPlayed.

	^ lastCardPlayed
]

{ #category : 'behavior' }
CardManager >> applyPermanentEffectOn: aShip overThrow: aThrow [

	| resultingThrow |
	resultingThrow := aThrow.

	activeCards do: [ :card |
			resultingThrow := card
				                  applyPermanentEffectOn: aShip
				                  overThrow: resultingThrow ].
	^ resultingThrow
]

{ #category : 'behavior' }
CardManager >> cancel: card [

	activeCards remove: card ifAbsent: [ self error: 'No permanent card of this type found' ]
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
