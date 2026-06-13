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

{ #category : 'behavior' }
Board >> applyEffectsOf: certainShip inGame: aGame [

	| square |
	(self shipInsideBoard: certainShip) ifFalse: [ ^ self ].
	
	square := squares at: (certainShip positionInBoard: self).
	square setLastEffectIn: self.
	
	
	square applyEffectToShip: certainShip inGame: aGame
]

{ #category : 'initialization' }
Board >> initializeWithSquares: aListOfSquares andLaps: aNumberOfLaps [

	squares := aListOfSquares.
	laps := aNumberOfLaps.
	lastEffect := Square new.
	
]

{ #category : 'accessing - editing state' }
Board >> lastEffect: _lastEffect [

	lastEffect := _lastEffect
]

{ #category : 'accessing' }
Board >> occurrencesOf: aSquareClass [

	| count |
	count := 0.
	squares do: [ :each |
		each class = aSquareClass ifTrue: [ count := count + 1 ] ].
	^ count
]

{ #category : 'behavior' }
Board >> repeatLastEffectsOn: ship inGame: aGame [

	lastEffect applyEffectToShip: ship inGame: aGame
]

{ #category : 'accessing' }
Board >> shipInsideBoard: aShip [

	^ (aShip lapsInBoard: self ) <= laps
]

{ #category : 'accessing' }
Board >> size [

	^ squares size.
]
