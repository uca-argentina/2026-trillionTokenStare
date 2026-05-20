Class {
	#name : 'SquarePool',
	#superclass : 'Object',
	#instVars : [
		'numberOfSquares',
		'probabilities'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SquarePool class >> defaultProbabilitiesWithSize: size [

	| probabilities |
	probabilities := {
		                 (Square -> 40).
		                 (Wormhole -> 20).
		                 (Speedup -> 20).
		                 (Moonwalk -> 10).
		                 (HyperJump -> 8).
		                 (AtomicBomb -> 2) } asDictionary.

	^ self new initializeWithSize: size andProbabilities: probabilities
]

{ #category : 'initialization' }
SquarePool >> createBoardWithLaps: numberOfLaps andParsecs: parsecs [

	| parsecsPerSquare bagOfEffects squares |
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
		  andLaps: numberOfLaps
]

{ #category : 'initialization' }
SquarePool >> initializeWithSize: size andProbabilities: _probabilities [

	numberOfSquares := size.
	probabilities := _probabilities 
]

{ #category : 'initialization' }
SquarePool >> numberOfSquares [

	^ numberOfSquares
]
