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

{ #category : 'initialization' }
Board >> initializeWithSquares: aListOfSquares [

	squares := aListOfSquares
]

{ #category : 'as yet unclassified' }
Board >> shipInTurn: playerTurn movesForward: diceValue andAffects: allShips [

	| shipInTurn updatedShips |
	updatedShips := allShips deepCopy.
	shipInTurn := allShips at: playerTurn.
	shipInTurn := shipInTurn movesForward: diceValue.
	shipInTurn := self shipLandsOnSquare: shipInTurn.
	updatedShips at: playerTurn put: shipInTurn.

	^ updatedShips
]

{ #category : 'as yet unclassified' }
Board >> shipInsideBoard: aShip [

	^ aShip position <= squares size
]

{ #category : 'as yet unclassified' }
Board >> shipLandsOnSquare: aShip [

	^ (self shipInsideBoard: aShip)
		  ifTrue: [ aShip landsOn: (squares at: aShip position) ]
		  ifFalse: [ ^ aShip ]
]
