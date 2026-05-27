Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> validateNumberOfSquares: numberOfSquares [

	numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: aListOfSquares [

	self validateNumberOfSquares: aListOfSquares size.
	"self validateParsecs: parsecs."

	^ self new initializeWithSquares: aListOfSquares andLaps: 1
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: aListOfSquares andLaps: aNumberOfLaps [

	self validateNumberOfSquares: aListOfSquares size.
	"self validateParsecs: parsecs."

	^ self new
		  initializeWithSquares: aListOfSquares
		  andLaps: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Board >> applyEffectsOf: certainShip to: listOfShips [

	| square |
	square := squares at: (certainShip positionInBoard: self).

	^ listOfShips collect: [ :ship | square applyEffectTo: ship in: self ]
]

{ #category : 'initialization' }
Board >> initializeWithSquares: aListOfSquares andLaps: aNumberOfLaps [

	squares := aListOfSquares.
	laps := aNumberOfLaps.
	
]

{ #category : 'accessing' }
Board >> occurrencesOf: aSquareType [

	| count |
	count := 0.
	squares do: [ :each |
		each = aSquareType ifTrue: [ count := count + 1 ] ].
	^ count
]

{ #category : 'as yet unclassified' }
Board >> shipInTurn: playerTurn movesForward: diceValue andAffects: allShips [

	| shipInTurn updatedShips |
	shipInTurn := (allShips at: playerTurn) movesForward: diceValue.
	updatedShips := allShips deepCopy.
	updatedShips at: playerTurn put: shipInTurn.

	^ self applyEffectsOf: shipInTurn to: updatedShips
]

{ #category : 'as yet unclassified' }
Board >> shipInsideBoard: aShip [

	^ (aShip lapsInBoard: self ) <= laps
]

{ #category : 'accessing' }
Board >> size [

	^ squares size.
]
