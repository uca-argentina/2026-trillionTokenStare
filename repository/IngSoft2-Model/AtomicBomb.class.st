Class {
	#name : 'AtomicBomb',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
AtomicBomb class >> defaultAt: squareNumber andParsecs: parsecs [ 

	^ self new initializeAt: squareNumber andParsecs: parsecs
]

{ #category : 'as yet unclassified' }
AtomicBomb >> applyEffectTo: aShip [

	^ aShip movesToPosition: 1
]
