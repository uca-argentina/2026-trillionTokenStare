Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dicePool',
		'playersTurn',
		'board',
		'cards'
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
Game >> initializeUsingBoard: aBoard andShips: listOfShips andDicePool: aDicePool [

	board := aBoard.
	ships := listOfShips.
	dicePool := aDicePool.
	cards := CardManager withActiveCards: {}.
	playersTurn := 1
]

{ #category : 'accessing' }
Game >> locateSpaceShip: nameOfSpaceship [

	^ (ships
		   detect: [ :ship | ship name = nameOfSpaceship ]
		   ifNone: [ self error: 'This spaceship does not exist' ])
		  asDictionaryInBoard: board
]

{ #category : 'accessing' }
Game >> locateWinningSpaceShip [

	^ (ships
		   detect: [ :aShip | (board shipInsideBoard: aShip) not ]
		   ifNone: [ self error: 'Game is not over' ]) asDictionaryInBoard:
		  board
]

{ #category : 'behaviour' }
Game >> nextPlayerThrowsDice [

	| amountToAdvance shipInTurn |
	self validateIfGameIsOver.
	shipInTurn := ships at: playersTurn.

	amountToAdvance := cards
		                   applyPermanentEffectOn: shipInTurn
		                   overThrow: dicePool throw.

	ships := board
		         shipInTurn: playersTurn
		         movesForward: amountToAdvance
		         andAffects: ships.

	playersTurn := playersTurn % ships size + 1
]

{ #category : 'behaviour' }
Game >> nextPlayerThrowsDiceAndUsesPermanentCard: aCard [

	| amountToAdvance shipInTurn |
	self validateIfGameIsOver.
	shipInTurn := ships at: playersTurn.

	cards addPermanentCard: aCard from: shipInTurn.

	amountToAdvance := cards
		                   applyPermanentEffectOn: shipInTurn
		                   overThrow: dicePool throw.

	ships := board
		         shipInTurn: playersTurn
		         movesForward: amountToAdvance
		         andAffects: ships.

	playersTurn := playersTurn % ships size + 1
]

{ #category : 'behaviour' }
Game >> nextPlayerUsesInstantCard: anInstantCard [

	| currentShip |
	currentShip := ships at: playersTurn.

	ships := cards
		         applyInstantEffectCard: anInstantCard
		         from: currentShip
		         withShips: ships
		         withBoard: board
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
