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

{ #category : 'creation' }
Spaceship class >> withName: aName [
	^ self new initializeWithName: aName andPosition: 1.
]

{ #category : 'creation' }
Spaceship class >> withName: aName andPosition: aPosition [
	^ self new initializeWithName: aName andPosition: aPosition.
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

{ #category : 'initialization' }
Spaceship >> initializeWithName: aName andPosition: aPosition [
	super initialize .
	name := aName .
	position := aPosition .
]

{ #category : 'changing state' }
Spaceship >> landsOn: aSquare [

	^ aSquare applyEffectTo: self
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

{ #category : 'accessing' }
Spaceship >> name [
	^ name.
]

{ #category : 'accessing' }
Spaceship >> position [
	^ position.
]
