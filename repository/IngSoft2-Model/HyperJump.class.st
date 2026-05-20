Class {
	#name : 'HyperJump',
	#superclass : 'Square',
	#instVars : [
		'jumps',
		'jumpIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperJump class >> defaultAt: squareNumber andJumps: listOfSquaresToJump andParsecs: parsecs [

	^ self new initializeAt: squareNumber withJumps: listOfSquaresToJump andParsecs: parsecs 
]

{ #category : 'accessing' }
HyperJump class >> defaultAt: squareNumber andParsecs: parsecs [

	^ self new
		  initializeAt: squareNumber
		  withJumps: { 300. 200 }
		  andParsecs: parsecs
]

{ #category : 'as yet unclassified' }
HyperJump >> applyEffectTo: aShip [

	| currentJump |
	^ aShip position = number
		  ifTrue: [
			  currentJump :=  ((jumps at: jumpIndex) / parsecs ) floor.
			  jumpIndex := jumpIndex % jumps size + 1.
			  ^ aShip movesForward: currentJump ]
		  ifFalse: [ ^ aShip ]
]

{ #category : 'accessing' }
HyperJump >> initializeAt: squareNumber withJumps: listOfJumps andParsecs: numberOfParsecs [
        number := squareNumber.
        parsecs := numberOfParsecs.
        jumps := listOfJumps sorted: [ :a :b | a > b ].
        jumpIndex := 1
]
