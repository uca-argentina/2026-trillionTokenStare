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
Spaceship class >> withName: aName [
	^ self new initializeWithName: aName .
]

{ #category : 'initialization' }
Spaceship >> initializeWithName: aName [
	super initialize .
	name := aName .
	position := 1 .
]

{ #category : 'initialization' }
Spaceship >> move: anAmmountOfSquares [
	position := position + anAmmountOfSquares.
	
]

{ #category : 'accessing' }
Spaceship >> position [
	^ position.
]
