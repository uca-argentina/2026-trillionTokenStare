Class {
	#name : 'AtomicBomb',
	#superclass : 'Square',
	#instVars : [
		'boardSize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
AtomicBomb class >> defaultAt: squareNumber [

	^ self new initializeAt: squareNumber 
]

{ #category : 'accessing' }
AtomicBomb class >> withSquareNumber: squareNumber [

	^ self new initializeAt: squareNumber 
]

{ #category : 'as yet unclassified' }
AtomicBomb >> applyEffectTo: aShip [
	| currentLap newAbsolutePosition |
	currentLap := (aShip position - 1) // boardSize.
	newAbsolutePosition := (currentLap * boardSize) + 1.
	
	^ aShip movesToPosition: newAbsolutePosition
]

{ #category : 'setter' }
AtomicBomb >> boardSize: aSize [
   boardSize := aSize
]

{ #category : 'as yet unclassified' }
AtomicBomb >> initializeAt: squareNumber [
	number := squareNumber.
	boardSize := 0

	
]
