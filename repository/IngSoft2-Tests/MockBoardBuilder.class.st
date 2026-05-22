Class {
	#name : 'MockBoardBuilder',
	#superclass : 'Object',
	#instVars : [
		'preloadedEffects',
		'numberOfSquares',
		'laps',
		'parsecs'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
MockBoardBuilder class >> withPreloadedSquares: listOfPreloadedEffects [

^self new initializeWith: listOfPreloadedEffects


]

{ #category : 'initialization' }
MockBoardBuilder >> build [

	| parsecsPerSquare |
	parsecsPerSquare := parsecs / preloadedEffects size.

	^ Board
		  withSquares:
			  (preloadedEffects withIndexCollect: [ :effect :index |
				   effect defaultAt: index andParsecs: parsecsPerSquare ])
		  andLaps: laps
]

{ #category : 'initialization' }
MockBoardBuilder >> createBoardWithLaps: numberOfLaps andParsecs: parsecs [

	| parsecsPerSquare |
	parsecsPerSquare := parsecs / preloadedEffects size.

	^ Board
		  withSquares:
			  (preloadedEffects withIndexCollect: [ :effect :index |
				   effect defaultAt: index andParsecs: parsecsPerSquare ])
		  andLaps: numberOfLaps
]

{ #category : 'initialization' }
MockBoardBuilder >> initialize [

	super initialize.
	preloadedEffects := (1 to: 10) collect: [ :i | Square ].
	numberOfSquares := preloadedEffects size.
	laps := 1.
	parsecs := 1000
]

{ #category : 'initialization' }
MockBoardBuilder >> initializeWith: aListOfPreloadedEffects [

	preloadedEffects := aListOfPreloadedEffects.
	numberOfSquares := aListOfPreloadedEffects size.
	
]

{ #category : 'initialization' }
MockBoardBuilder >> numberOfSquares [

	^ numberOfSquares
]

{ #category : 'initialization' }
MockBoardBuilder >> withEffects: aListOfPreloadedEffects [

	preloadedEffects := aListOfPreloadedEffects.
	numberOfSquares := aListOfPreloadedEffects size.
	
]

{ #category : 'initialization' }
MockBoardBuilder >> withLaps: _laps [

	laps := _laps 
]

{ #category : 'initialization' }
MockBoardBuilder >> withParsecs: _parsecs [

	parsecs := _parsecs
]

{ #category : 'initialization' }
MockBoardBuilder >> withSquares: _numberOfSquares [

	preloadedEffects := (1 to: _numberOfSquares) collect: [ :i | Square ].
	numberOfSquares := _numberOfSquares
]
