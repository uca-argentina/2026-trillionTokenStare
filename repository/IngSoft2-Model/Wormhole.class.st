Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Wormhole class >> defaultAt: squareNumber [

	^ self new initializeAt: squareNumber 
]

{ #category : 'as yet unclassified' }
Wormhole >> applyEffectTo: aShip [

	^ aShip position = number
		  ifTrue: [ ^ aShip movesBackward: 4. ]
		  ifFalse: [ ^ aShip ].
]
