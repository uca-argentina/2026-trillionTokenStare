Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'cards'
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
	^ self new initializeWithName: aName andPosition: 1 andCards: {  }
]

{ #category : 'creation' }
Spaceship class >> withName: aName andPosition: aPosition [

	self validateName: aName.
	^ self new initializeWithName: aName andPosition: aPosition andCards: {  }
]

{ #category : 'creation' }
Spaceship class >> withName: aName andPosition: aPosition andCards: _cards [

	self validateName: aName.
	^ self new initializeWithName: aName andPosition: aPosition andCards: _cards 
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
Spaceship >> asDictionaryWithCardsInBoard: aBoard [

	^ {
		  (#name -> name).
		  (#position -> (self positionInBoard: aBoard)).
		  (#lap -> (self lapsInBoard: aBoard)).
		  (#cards -> (cards deepCopy)) } asDictionary
]

{ #category : 'initialization' }
Spaceship >> initializeWithName: aName andPosition: aPosition andCards: _cards [
	super initialize .
	name := aName .
	position := aPosition .
	cards:= _cards asOrderedCollection 
]

{ #category : 'accessing' }
Spaceship >> lapsInBoard: board [

	^ position - 1 // board size + 1
]

{ #category : 'behavior' }
Spaceship >> movesBackward: anAmmountOfSquares [

	| newPosition |
	newPosition := position - anAmmountOfSquares max: 1.

	^ self class withName: name andPosition: newPosition andCards: cards
]

{ #category : 'behavior' }
Spaceship >> movesForward: anAmmountOfSquares [

	| newPosition |
	newPosition := position + anAmmountOfSquares.

	^ self class withName: name andPosition: newPosition andCards: cards
]

{ #category : 'behavior' }
Spaceship >> movesToPosition: aPosition InBoard: board [

	| currentNumericalLap newAbsolutePosition |
	currentNumericalLap := (self lapsInBoard: board) - 1.
	newAbsolutePosition := currentNumericalLap * board size + aPosition.

	^ self class withName: name andPosition: newAbsolutePosition andCards: cards 
]

{ #category : 'accessing' }
Spaceship >> name [
	^ name.
]

{ #category : 'behavior' }
Spaceship >> playCard: aCard [

	^ cards
		  detect: [ :eachCard | eachCard = aCard ]
		  ifFound: [ :myCard |
				  cards remove: myCard.
				  aCard ]
		  ifNone: [ self error: 'Ship can not play a card that doesnt posess' ]
]

{ #category : 'accessing' }
Spaceship >> position [
	^ position.
]

{ #category : 'accessing' }
Spaceship >> positionInBoard: board [
	^ position - 1 % board size + 1
]

{ #category : 'behavior' }
Spaceship >> receivesCard: _card [

	cards add: _card
]
