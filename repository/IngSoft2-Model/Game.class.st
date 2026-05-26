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
		  initializeUsingSquarePool: (MockBoardBuilder withPreloadedSquares:
				   (OrderedCollection new: numberOfSquares withAll: Square))
		  andShips: listOfShips
		  andDicePool: aDicePool
		  andLaps: numberOfLaps
		  andParsecs: parsecs
]

{ #category : 'initialization' }
Game >> initializeUsingSquarePool: aBoardBuilder andShips: listOfShips andDicePool: aDicePool andLaps: numberOfLaps andParsecs: parsecs [

	board := (aBoardBuilder withLaps: numberOfLaps; withParsecs: parsecs)
		         build.
	ships := listOfShips. "(1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)]."
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
			                      'This spaceship does not exist' ].
	positionOnBoard := ((aSpaceShipPosition position - 1) % board size) + 1.
	currentLap := ((aSpaceShipPosition position - 1) // board size) + 1.
	
	^ { #position -> positionOnBoard . #lap -> currentLap } asDictionary
]

{ #category : 'accessing' }
Game >> locateWinningSpaceShip [

	| positionOnBoard currentLap winningSpaceShip |.

	winningSpaceShip := ships
		                    detect: [ :aShip |
		                    (board shipInsideBoard: aShip) not ]
		                    ifNone: [
		                    self error:
			                    'Game is not over' ].

	positionOnBoard := winningSpaceShip position - 1 % board size + 1.
	currentLap := winningSpaceShip position - 1 // board size + 1.

	^ {
		  (#name -> winningSpaceShip name).
		  (#position -> positionOnBoard).
		  (#lap -> currentLap) } asDictionary
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

	(ships anySatisfy: [ :aShip | (board shipInsideBoard: aShip) not ])
		ifTrue: [ self error: 'Game is over, no more turns allowed' ]
]
