Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dicePool',
		'playersTurn',
		'board',
		'laps'
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

	numberOfShips size < 2 ifTrue: [
		self error: 'The board must have at least 2 ships.' ]
]

{ #category : 'validation' }
Game class >> validateNumberOfSquares: numberOfSquares [

	numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'validation' }
Game class >> validateParsecs: parsecs [

	parsecs < 1000 ifTrue: [
		self error: 'The board must have at least 1000 parsecs.' ]
]

{ #category : 'creation' }
Game class >> withSquarePool: squarePool andShips: listOfShips andDicePool: aDicePool andLaps: numberOfLaps andParsecs: parsecs [

	self validateNumberOfShips: listOfShips.
	self validateNumberOfSquares: squarePool numberOfSquares .
	self validateDicePool: aDicePool.
	self validateParsecs: parsecs.
	

	^ self new
		  initializeUsingSquarePool: squarePool
		  andShips: listOfShips
		  andDicePool: aDicePool
		  andLaps: numberOfLaps
		  andParsecs: parsecs
]

{ #category : 'creation' }
Game class >> withSquares: numberOfSquares andShips: listOfShips andDicePool: aDicePool andLaps: numberOfLaps andParsecs: parsecs [

	self validateNumberOfShips: listOfShips.
	self validateNumberOfSquares: numberOfSquares.
	self validateDicePool: aDicePool.
	self validateParsecs: parsecs.

	^ self new
		  initializeUsingSquarePool: (MockSquarePool withPreloadedSquares:
				   (OrderedCollection new: numberOfSquares withAll: Square))
		  andShips: listOfShips
		  andDicePool: aDicePool
		  andLaps: numberOfLaps
		  andParsecs: parsecs
]

{ #category : 'boolean' }
Game >> gameIsOver [

	
	^ ships anySatisfy: [ :aShip | (board shipInsideBoard: aShip) not ].
]

{ #category : 'initialization' }
Game >> initializeUsingSquarePool: aSqarePool andShips: listOfShips andDicePool: aDicePool andLaps: numberOfLaps andParsecs: parsecs [

	board := aSqarePool createBoardWithLaps: numberOfLaps andParsecs: parsecs.
	ships := listOfShips."(1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)]."
	dicePool := aDicePool.
	playersTurn := 1
]

{ #category : 'accessing' }
Game >> locateSpaceShip: aSpaceShip [

	| aSpaceShipPosition positionOnBoard currentLap |
	aSpaceShipPosition := ships
		                      detect: [ :ship | ship name = aSpaceShip ]
		                      ifNone: [
		                      self error:
			                      'The selected SpaceShip is not on the board' ].
	positionOnBoard := ((aSpaceShipPosition position - 1) % board size) + 1.
	currentLap := ((aSpaceShipPosition position - 1) // board size) + 1.
	
	^ { #position -> positionOnBoard . #lap -> currentLap } asDictionary
]

{ #category : 'behaviour' }
Game >> nextTurn [

	| diceValue updatedShips |
	self validateIfGameIsOver.
	diceValue := dicePool throw.
	updatedShips := board shipInTurn: playersTurn movesForward: diceValue andAffects: ships .
	ships := updatedShips.
	
	playersTurn := playersTurn % ships size + 1
]

{ #category : 'behaviour' }
Game >> ranking [
        ^ Ranking new bestThreeSpaceShips: ships asOrderedCollection
]

{ #category : 'validation' }
Game >> validateIfGameIsOver [

	self gameIsOver ifTrue: [
		self error: 'Game is over, no more turns allowed' ]
]

{ #category : 'accessing' }
Game >> whoWon [

	self gameIsOver ifFalse: [ self error: 'Game isnt over' ].

	^ ships detect: [ :aShip | (board shipInsideBoard: aShip) not ]
]
