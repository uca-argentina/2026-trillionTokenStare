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
AtomicBomb class >> defaultAt: squareNumber andParsecs: parsecs [ 

	^ self new initializeAt: squareNumber andParsecs: parsecs
]

{ #category : 'as yet unclassified' }
AtomicBomb >> applyEffectTo: aShip in: aBoard [

	^ aShip movesToPosition: 1 InBoard: aBoard
]
