Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> validateNumberOfShips: numberOfShips [

	numberOfShips < 2 ifTrue: [
		self error: 'The board must have at least 2 ships.' ]
]

{ #category : 'as yet unclassified' }
Board class >> validateNumberOfSquares: numberOfSquares [

	numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withShips: numberOfShips [

	self validateNumberOfShips: numberOfShips.
	^ self new initializeWithSquares: 1 andShips: numberOfShips
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: numberOfSquares [

	self validateNumberOfSquares: numberOfSquares.
	^ self new initializeWithSquares: numberOfSquares andShips: 2
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: numberOfSquares andShips: numberOfShips [

	self validateNumberOfShips: numberOfShips.
	self validateNumberOfSquares: numberOfSquares.
	^ self new
		  initializeWithSquares: numberOfSquares
		  andShips: numberOfShips
]

{ #category : 'initialization' }
Board >> initializeWithSquares: numberOfSquares andShips: numberOfShips [

	squares := numberOfSquares .
	ships := numberOfShips 
]
