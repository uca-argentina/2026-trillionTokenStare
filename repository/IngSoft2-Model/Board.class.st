Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares',
		'laps',
		'lastEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> validateContiguousSquares: aListOfSquares [

	aListOfSquares overlappingPairsDo: [ :current :next |
		current position + 1 = next position ifFalse: [ self error: 'Squares are required to be contiguous to each other' ] ]
]

{ #category : 'as yet unclassified' }
Board class >> validateFirstSquareIsAtPositionOne: aListOfSquares [

	aListOfSquares first position = 1 ifFalse: [
		self error: 'First square position must be 1' ]
]

{ #category : 'as yet unclassified' }
Board class >> validateNumberOfSquares: numberOfSquares [

	numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'as yet unclassified' }
Board class >> validateUniformAmountOfParsecs: aListOfSquares [

	aListOfSquares overlappingPairsDo: [ :current :next |
		current parsecs = next parsecs ifFalse: [ self error: 'Squares are required to all have the same amount of parsecs' ] ]
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: aListOfSquares [

	self validateNumberOfSquares: aListOfSquares size.
	self validateContiguousSquares: aListOfSquares.
	self validateFirstSquareIsAtPositionOne: aListOfSquares .
	self validateUniformAmountOfParsecs: aListOfSquares.

	^ self new initializeWithSquares: aListOfSquares andLaps: 1
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: aListOfSquares andLaps: aNumberOfLaps [

	self validateNumberOfSquares: aListOfSquares size.
	self validateContiguousSquares: aListOfSquares.
	self validateFirstSquareIsAtPositionOne: aListOfSquares .
	self validateUniformAmountOfParsecs: aListOfSquares.

	^ self new
		  initializeWithSquares: aListOfSquares
		  andLaps: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Board >> applyEffectsOf: certainShip to: listOfShips [

	| square |
	square := squares at: (certainShip positionInBoard: self).
	
	"((square isKindOf: Square) and: [ square class ~~ Square ]) ifTrue: [
		lastEffect := square ]."
	lastEffect := Speedup new.

	^ listOfShips collect: [ :ship | square applyEffectTo: ship in: self ]
]

{ #category : 'as yet unclassified' }
Board >> applyLastEffectTo: shipThatReceivesEffect in: listOfShips [

	| updatedShips |
	updatedShips := listOfShips deepCopy.
	updatedShips collect: [ :ship | lastEffect applyEffectTo: ship in: self ].

	^ updatedShips
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
	(self shipInsideBoard: shipInTurn) ifTrue: [
		^ self applyEffectsOf: shipInTurn to: updatedShips ].

	^ updatedShips
]

{ #category : 'as yet unclassified' }
Board >> shipInsideBoard: aShip [

	^ (aShip lapsInBoard: self ) <= laps
]

{ #category : 'accessing' }
Board >> size [

	^ squares size.
]
