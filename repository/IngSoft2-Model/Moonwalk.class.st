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
Moonwalk class >> defaultAt: squareNumber andParsecs: parsecs [

	^ self new initializeAt: squareNumber WithBacktrack: 3 andNumberOfParsecs: parsecs 
]

{ #category : 'accessing' }
Moonwalk class >> defaultAt: squareNumber withBacktrack: backtrack andParsecs: parsecs [

	^ self new
		  initializeAt: squareNumber
		  WithBacktrack: backtrack
		  andNumberOfParsecs: parsecs
]

{ #category : 'accessing' }
Moonwalk class >> randomAt: squareNumber andParsecs: parsecs [
        ^ self new
                initializeAt: squareNumber
                WithBacktrack: (2 to: 6) atRandom
                andNumberOfParsecs: parsecs
]

{ #category : 'as yet unclassified' }
Moonwalk >> applyEffectTo: aShip in: aBoard [

	aShip position = number ifTrue: [ ^ aShip ].
	^ aShip movesBackward: backtrack
]

{ #category : 'accessing' }
Moonwalk >> backtrack [
        ^ backtrack
]

{ #category : 'initialization' }
Moonwalk >> initializeAt: squareNumber WithBacktrack: anAmountToBacktrack andNumberOfParsecs: numberOfParsecs [

	backtrack := anAmountToBacktrack.
	number := squareNumber.
	parsecs:= numberOfParsecs
]
