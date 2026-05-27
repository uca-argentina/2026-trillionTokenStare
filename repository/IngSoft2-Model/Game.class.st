Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dicePool',
		'playersTurn',
		'board'
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

{ #category : 'creation' }
Game class >> withBoard: aBoard andShips: listOfShips andDicePool: aDicePool [
	"andLaps: numberOfLaps andParsecs: parsecs"

	self validateNumberOfShips: listOfShips.
	self validateDicePool: aDicePool.

	^ self new
		  initializeUsingBoard: aBoard
		  andShips: listOfShips
		  andDicePool: aDicePool
]

{ #category : 'initialization' }
Game >> initializeUsingBoard: aBoard andShips: listOfShips andDicePool: aDicePool [ "andLaps: numberOfLaps andParsecs: parsecs"

	board := aBoard.
	ships := listOfShips. "(1 to: numberOfShips) collect: [:number | (Spaceship withName: number asString)]."
	dicePool := aDicePool.
	playersTurn := 1
]

{ #category : 'accessing' }
Game >> locateSpaceShip: aSpaceshipName [

	| aSpaceShip |
	aSpaceShip := ships
		              detect: [ :ship | ship name = aSpaceshipName ]
		              ifNone: [ self error: 'This spaceship does not exist' ].


	^ {
		  (#name -> aSpaceShip name).
		  (#position -> (aSpaceShip positionInBoard: board )).
		  (#lap -> (aSpaceShip lapsInBoard: board )) } asDictionary
]

{ #category : 'accessing' }
Game >> locateWinningSpaceShip [

	| winningSpaceShip |
	winningSpaceShip := ships
		                    detect: [ :aShip |
		                    (board shipInsideBoard: aShip) not ]
		                    ifNone: [ self error: 'Game is not over' ].
	^ {
		  (#name -> winningSpaceShip name).
		  (#position -> (winningSpaceShip positionInBoard: board )).
		  (#lap -> (winningSpaceShip lapsInBoard: board )) }
		  asDictionary
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
