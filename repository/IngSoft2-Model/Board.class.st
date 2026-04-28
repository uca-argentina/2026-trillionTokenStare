Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withSquares: numberOfSquares [
	numberOfSquares < 1 ifTrue: [ self error: 'The board must have at least 1 square.' ].
  ^ self new initializeWithSquares: numberOfSquares 
]

{ #category : 'initialization' }
Board >> initializeWithSquares: numberOfSquares [

	squares := numberOfSquares .
]
