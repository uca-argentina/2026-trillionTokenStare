Class {
	#name : 'Moonwalk',
	#superclass : 'Square',
	#instVars : [
		'backtrack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Moonwalk class >> defaultAt: squareNumber [

	^ self new initializeAt: squareNumber WithBacktrack: 3
]

{ #category : 'as yet unclassified' }
Moonwalk >> applyEffectTo: aShip [
	
	^ aShip position = number
		  ifTrue: [ ^ aShip ]
		  ifFalse: [ ^ aShip movesBackward: backtrack ]
]

{ #category : 'initialization' }
Moonwalk >> initializeAt: squareNumber WithBacktrack: anAmountToBacktrack [

	backtrack := anAmountToBacktrack.
	number := squareNumber
]
