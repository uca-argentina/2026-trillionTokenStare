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

{ #category : 'building' }
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
				   effect deepCopy atPosition: index; withParsecs: parsecsPerSquare ])
		  andLaps: laps
]

{ #category : 'initialization' }
BoardBuilder >> initialize [

	super initialize.
	laps := 1.
	parsecs := 1000.
	numberOfSquares := 10.
	probabilities := {
		                 (Square new-> 40).
		                 (Wormhole new-> 20).
		                 (Speedup new-> 20).
		                 (Moonwalk new-> 10).
		                 (HyperJump new-> 8).
		                 (AtomicBomb new-> 2) } asDictionary
]

{ #category : 'accessing' }
BoardBuilder >> numberOfSquares [

	^ numberOfSquares
]

{ #category : 'validation' }
BoardBuilder >> validateParsecs [

	parsecs < 1000 ifTrue: [
		self error: 'The board must have at least 1000 parsecs.' ]
]

{ #category : 'validation' }
BoardBuilder >> validateSquares [

	 numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'behavior' }
BoardBuilder >> withLaps: _laps [

	laps := _laps.
	^ self
]

{ #category : 'behavior' }
BoardBuilder >> withLightYears: _lightYears [

	parsecs := _lightYears * 3.
	^ self
]

{ #category : 'behavior' }
BoardBuilder >> withParsecs: _parsecs [

	parsecs := _parsecs.
	^ self
]

{ #category : 'behavior' }
BoardBuilder >> withProbabilities: _probabilities [

	probabilities := _probabilities.
	^ self
]

{ #category : 'behavior' }
BoardBuilder >> withSquares: _squares [

	numberOfSquares := _squares.
	^ self
]
