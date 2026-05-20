Class {
	#name : 'MockSquarePool',
	#superclass : 'Object',
	#instVars : [
		'preloadedEffects',
		'numberOfSquares'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
MockSquarePool class >> withPreloadedSquares: listOfPreloadedEffects [

^self new initializeWith: listOfPreloadedEffects


]

{ #category : 'initialization' }
MockSquarePool >> createBoardWithLaps: numberOfLaps andParsecs: parsecs [

	| parsecsPerSquare |
	parsecsPerSquare := parsecs / preloadedEffects size.

	^ Board
		  withSquares:
			  (preloadedEffects withIndexCollect: [ :effect :index |
				   effect defaultAt: index andParsecs: parsecsPerSquare ])
		  andLaps: numberOfLaps
]

{ #category : 'initialization' }
MockSquarePool >> initializeWith: aListOfPreloadedEffects [

	preloadedEffects := aListOfPreloadedEffects.
	numberOfSquares := aListOfPreloadedEffects size
]

{ #category : 'initialization' }
MockSquarePool >> numberOfSquares [

	^ numberOfSquares
]
