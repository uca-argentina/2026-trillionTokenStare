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
CardManager >> addPermanentCard: card from: shipInTurn [

	activeCards add: (shipInTurn playCard: card)
]

{ #category : 'initialization' }
CardManager >> applyInstantEffectCard: card from: shipInTurn withShips: listOfShips withBoard: board [

	(shipInTurn playCard: card)
		withCardManager: self;
		withShips: listOfShips;
		withBoard: board;
		applyInstantEffect
]

{ #category : 'initialization' }
CardManager >> applyPermanentEffectOn: aShip overThrow: aThrow [

	| resultingThrow |
	resultingThrow := aThrow.

	activeCards do: [ :card |
		resultingThrow := card
			                  applyPermanentEffectOn: aShip
			                  overThrow: resultingThrow ].
	^ resultingThrow
]

{ #category : 'initialization' }
CardManager >> cancel: card [

	activeCards remove: card ifAbsent: [ self error: 'No permanent card of this type found' ]
]

{ #category : 'initialization' }
CardManager >> initializeWithActiveCards: _cards [

	super initialize.
	activeCards := _cards asOrderedCollection 
]

{ #category : 'as yet unclassified' }
CardManager >> permanentCards [

	^ activeCards
]
