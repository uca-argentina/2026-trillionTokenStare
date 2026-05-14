Class {
	#name : 'MockSquarePool',
	#superclass : 'SquarePool',
	#instVars : [
		'preloadedEffects',
		'numberOfSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MockSquarePool class >> withPreloadedSquares: listOfPreloadedEffects [

^self new initializeWith: listOfPreloadedEffects


]

{ #category : 'initialization' }
MockSquarePool >> createBoard [

	^ preloadedEffects collect: [ :effect | effect new ]
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
