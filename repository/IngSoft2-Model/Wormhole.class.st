Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Wormhole class >> defaultAt: squareNumber andParsecs: parsecs [

	^ self new initializeAt: squareNumber andParsecs: parsecs 
]

{ #category : 'as yet unclassified' }
Wormhole >> applyEffectTo: aShip in: aBoard [

	^ aShip position = number
		  ifTrue: [ ^ aShip movesBackward: 4. ]
		  ifFalse: [ ^ aShip ].
]
