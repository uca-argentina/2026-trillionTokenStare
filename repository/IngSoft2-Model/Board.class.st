Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withSquares: aListOfSquares [

	^ self new initializeWithSquares: aListOfSquares
]

{ #category : 'as yet unclassified' }
Board >> applyEffectsOf: certainShip to: listOfShips [

	| square |
	square := squares at: certainShip position.

	^ listOfShips collect: [ :ship | square applyEffectTo: ship ]
]

{ #category : 'initialization' }
Board >> initializeWithSquares: aListOfSquares [

	squares := aListOfSquares
]

{ #category : 'as yet unclassified' }
Board >> shipInTurn: playerTurn movesForward: diceValue andAffects: allShips [

	| shipInTurn updatedShips |
	'Copy of the original ship positions'.
	updatedShips := allShips deepCopy.
	'Ship in turn moves according to dice roll'.
	shipInTurn := allShips at: playerTurn.
	shipInTurn := shipInTurn movesForward: diceValue.
	'New position is stored at the intermediate ship positions collection'.
	updatedShips at: playerTurn put: shipInTurn.
	'apply effects on all the ships according to where the ship in turn landed'.
	(self shipInsideBoard: shipInTurn) ifTrue: [
		updatedShips := self applyEffectsOf: shipInTurn to: updatedShips ].
	^ updatedShips
]

{ #category : 'as yet unclassified' }
Board >> shipInsideBoard: aShip [

	^ aShip position <= squares size
]
