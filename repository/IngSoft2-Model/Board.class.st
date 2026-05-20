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
Board class >> withSquares: aListOfSquares [

	^ self new initializeWithSquares: aListOfSquares andLaps: 1
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: aListOfSquares andLaps: aNumberOfLaps [

	^ self new 
	    initializeWithSquares: aListOfSquares
	    andLaps: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Board >> applyEffectsOf: certainShip to: listOfShips [

	| square fixedPosition|
	fixedPosition := (certainShip position - 1) % (squares size) + 1 .
	square := (squares at: fixedPosition ).

	^ listOfShips collect: [ :ship | square applyEffectTo: ship ]
]

{ #category : 'initialization' }
Board >> initializeWithSquares: aListOfSquares andLaps: aNumberOfLaps [

	squares := aListOfSquares.
	laps := aNumberOfLaps.
	squares do: [ :square | 
      (square respondsTo: #boardSize:) ifTrue: [ square boardSize: squares size ] 
   ]
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

	^ aShip position <= (laps * squares size)
	
]

{ #category : 'accessing' }
Board >> size [

	^ squares size.
]
