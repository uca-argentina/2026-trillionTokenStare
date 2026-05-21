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
	| currentLap newAbsolutePosition |
	currentLap := (aShip position - 1) // aBoard size.
	newAbsolutePosition := (currentLap * aBoard size) + 1.
	
	^ aShip movesToPosition: newAbsolutePosition
]
