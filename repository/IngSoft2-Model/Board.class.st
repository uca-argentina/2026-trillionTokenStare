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
Board >> applyEffectsOf: shipInTurn to: intermediateShips [

	^ intermediateShips collect: [ :ship |
		  (self shipInsideBoard: shipInTurn)
			  ifTrue: [ (squares at: shipInTurn position) applyEffectTo: ship ]
			  ifFalse: [ ship ] ]
]

{ #category : 'initialization' }
Board >> initializeWithSquares: aListOfSquares [

	squares := aListOfSquares
]

{ #category : 'as yet unclassified' }
Board >> shipInTurn: playerTurn movesForward: diceValue andAffects: allShips [

	| shipInTurn intermediateShips finalShips |
	'Copy of the original ship positions'.
	intermediateShips := allShips deepCopy.
	'Ship in turn moves according to dice roll'.
	shipInTurn := allShips at: playerTurn.
	shipInTurn := shipInTurn movesForward: diceValue.
	'New position is stored at the intermediate ship positions collection'.
	intermediateShips at: playerTurn put: shipInTurn.
	'apply effects on all the ships according to where the ship in turn landed'.
	finalShips := self applyEffectsOf: shipInTurn to: intermediateShips.

	^ finalShips
]

{ #category : 'as yet unclassified' }
Board >> shipInsideBoard: aShip [

	^ aShip position <= squares size
]
