Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'squares',
		'ships',
		'dicePool',
		'playersTurn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Game class >> validateDicePool: aDicePool [

	(aDicePool isMemberOf: DicePool) ifFalse: [
		self error:
			'Board must receive a Dice Pool, not a collection, not a single Dice' ]
]

{ #category : 'validation' }
Game class >> validateNumberOfShips: numberOfShips [

	numberOfShips < 2 ifTrue: [
		self error: 'The board must have at least 2 ships.' ]
]

{ #category : 'validation' }
Game class >> validateNumberOfSquares: numberOfSquares [

	numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'creation' }
Game class >> withPreloadedSquares: numberOfSquares [

	self validateNumberOfSquares: numberOfSquares.
	^ self new
		  initializeUsingSquarePool: (MockSquarePool withPreloadedSquares: (OrderedCollection new: numberOfSquares withAll: Square ))
		  andShips: 2
		  andDicePool: (DicePool withDice: { (Dice withSides: 4) })
]

{ #category : 'creation' }
Game class >> withShips: numberOfShips [

	self validateNumberOfShips: numberOfShips.
	^ self new
		  initializeUsingSquarePool: (MockSquarePool withPreloadedSquares: (OrderedCollection new: 1 withAll: Square ))
		  andShips: numberOfShips
		  andDicePool: (DicePool withDice: { (Dice withSides: 4) })
]

{ #category : 'creation' }
Game class >> withSquarePool: squarePool andShips: numberOfShips andDicePool: aDicePool [

	self validateNumberOfShips: numberOfShips.
	self validateNumberOfSquares:( squarePool numberOfSquares).
	self validateDicePool: aDicePool.

	^ self new
		  initializeUsingSquarePool: squarePool
		  andShips: numberOfShips
		  andDicePool: aDicePool
]

{ #category : 'creation' }
Game class >> withSquares: numberOfSquares andShips: numberOfShips andDicePool: aDicePool [

	self validateNumberOfShips: numberOfShips.
	self validateNumberOfSquares: numberOfSquares.
	self validateDicePool: aDicePool.

	^ self new
		  initializeUsingSquarePool: (MockSquarePool withPreloadedSquares: (OrderedCollection new: numberOfSquares withAll: Square ))
		  andShips: numberOfShips
		  andDicePool: aDicePool
]

{ #category : 'boolean' }
Game >> gameIsOver [

	
	^ ships anySatisfy: [ :aShip | (squares shipInsideBoard: aShip) not ].
]

{ #category : 'initialization' }
Game >> initializeUsingSquarePool: aSqarePool andShips: numberOfShips andDicePool: aDicePool [

	squares := aSqarePool createBoard.
	ships := OrderedCollection new.
	1 to: numberOfShips do: [ :i | ships add: (Spaceship withName: i) ].
	dicePool := aDicePool.
	playersTurn := 1
]

{ #category : 'accessing' }
Game >> locateSpaceShip: aSpaceShip [

	| aSpaceShipPosition |
	aSpaceShipPosition := ships
		                      detect: [ :ship | ship name = aSpaceShip ]
		                      ifNone: [
		                      self error:
			                      'The selected SpaceShip is not on the board' ].
	^ aSpaceShipPosition position
]

{ #category : 'behaviour' }
Game >> nextTurn [

	| diceValue updatedShips |
	self validateIfGameIsOver.
	diceValue := dicePool throw.
	updatedShips := squares shipInTurn: playersTurn movesForward: diceValue andAffects: ships .
	ships := updatedShips.
	
	playersTurn := playersTurn % ships size + 1
]

{ #category : 'accessing' }
Game >> ships [

	^ ships
]

{ #category : 'validation' }
Game >> validateIfGameIsOver [

	self gameIsOver ifTrue: [
		self error: 'Game is over, no more turns allowed' ]
]

{ #category : 'accessing' }
Game >> whoWon [

	self gameIsOver ifFalse: [ self error: 'Game isnt over' ].

	^ ships detect: [ :aShip | (squares shipInsideBoard: aShip) not ]
]
