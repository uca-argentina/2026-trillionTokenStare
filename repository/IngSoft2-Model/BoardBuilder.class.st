Class {
	#name : 'BoardBuilder',
	#superclass : 'Object',
	#instVars : [
		'numberOfSquares',
		'probabilities',
		'laps',
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
BoardBuilder >> build [

	| parsecsPerSquare bagOfEffects squares |
	"self validateNumberOfSquares: aListOfSquares size."
	self validateParsecs.
	self validateSquares.
	parsecsPerSquare := parsecs / numberOfSquares.
	bagOfEffects := OrderedCollection
		                new: numberOfSquares
		                streamContents: [ :stream |
				                probabilities keysAndValuesDo: [ :effect :percent |
						                | cuantity |
						                cuantity := (numberOfSquares * percent / 100)
							                            asInteger.
						                cuantity timesRepeat: [ stream nextPut: effect ] ] ].
	squares := bagOfEffects shuffle.
	^ Board
		  withSquares: (squares withIndexCollect: [ :effect :index |
				   effect randomAt: index andParsecs: parsecsPerSquare ])
		  andLaps: laps
]

{ #category : 'initialization' }
BoardBuilder >> initialize [

	super initialize.
	laps := 1.
	parsecs := 1000.
	numberOfSquares := 10.
	probabilities := {
		                 (Square -> 40).
		                 (Wormhole -> 20).
		                 (Speedup -> 20).
		                 (Moonwalk -> 10).
		                 (HyperJump -> 8).
		                 (AtomicBomb -> 2) } asDictionary
]

{ #category : 'initialization' }
BoardBuilder >> numberOfSquares [

	^ numberOfSquares
]

{ #category : 'initialization' }
BoardBuilder >> validateParsecs [

	parsecs < 1000 ifTrue: [
		self error: 'The board must have at least 1000 parsecs.' ]
]

{ #category : 'initialization' }
BoardBuilder >> validateSquares [

	 numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'initialization' }
BoardBuilder >> withLaps: _laps [

	laps := _laps.
	^ self
]

{ #category : 'initialization' }
BoardBuilder >> withParsecs: _parsecs [

	parsecs := _parsecs.
	^ self
]

{ #category : 'initialization' }
BoardBuilder >> withProbabilities: _probabilities [

	probabilities := _probabilities.
	^ self
]

{ #category : 'initialization' }
BoardBuilder >> withSquares: _squares [

	numberOfSquares := _squares.
	^ self
]
