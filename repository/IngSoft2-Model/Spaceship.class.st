Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Spaceship class >> validateName: aName [

	(aName isString) ifFalse: [
		self error: 'Name of spaceship must be a string' ]
]

{ #category : 'creation' }
Spaceship class >> withName: aName [
	self validateName: aName .
	^ self new initializeWithName: aName andPosition: 1.
]

{ #category : 'creation' }
Spaceship class >> withName: aName andPosition: aPosition [

	self validateName: aName.
	^ self new initializeWithName: aName andPosition: aPosition
]

{ #category : 'accessing' }
Spaceship >> = unaNave [
    "1. Misma identidad"
    self == unaNave ifTrue: [ ^ true ].
    "2. Misma clase"
    self class = unaNave class ifFalse: [ ^ false ].
    "3. Mismos atributos clave"
    ^ self name = unaNave name and: [ self position = unaNave position ]
]

{ #category : 'accessing' }
Spaceship >> asDictionaryInBoard: aBoard [

	^ {
		  (#name -> name).
		  (#position -> (self positionInBoard: aBoard)).
		  (#lap -> (self lapsInBoard: aBoard)) } asDictionary
]

{ #category : 'initialization' }
Spaceship >> initializeWithName: aName andPosition: aPosition [
	super initialize .
	name := aName .
	position := aPosition .
]

{ #category : 'accessing' }
Spaceship >> lapsInBoard: board [

	^ position - 1 // board size + 1
]

{ #category : 'changing state' }
Spaceship >> movesBackward: anAmmountOfSquares [

	| newPosition |
	newPosition := position - anAmmountOfSquares max: 1.

	^ self class withName: name andPosition: newPosition
]

{ #category : 'changing state' }
Spaceship >> movesForward: anAmmountOfSquares [

	| newPosition |
	newPosition := position + anAmmountOfSquares.

	^ self class withName: name andPosition: newPosition
]

{ #category : 'changing state' }
Spaceship >> movesToPosition: aPosition InBoard: board [

	| currentNumericalLap newAbsolutePosition |
	currentNumericalLap := (self lapsInBoard: board) - 1.
	newAbsolutePosition := currentNumericalLap * board size + aPosition.

	^ self class withName: name andPosition: newAbsolutePosition
]

{ #category : 'accessing' }
Spaceship >> name [
	^ name.
]

{ #category : 'accessing' }
Spaceship >> position [
	^ position.
]

{ #category : 'accessing' }
Spaceship >> positionInBoard: board [
	^ position - 1 % board size + 1
]
