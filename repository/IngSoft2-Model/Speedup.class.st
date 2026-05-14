Class {
	#name : 'Speedup',
	#superclass : 'Square',
	#instVars : [
		'boardSize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Speedup class >> defaultAt: squareNumber [

	^ self new initializeAt: squareNumber
]

{ #category : 'as yet unclassified' }
Speedup >> applyEffectTo: aShip [

	^ aShip position = number
		  ifTrue: [ ^ aShip movesForward: 4. ]
		  ifFalse: [ ^ aShip ].
]
