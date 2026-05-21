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
