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
	ships := SpaceshipManager withShips: listOfShips .
	dicePool := aDicePool.
	cards := CardManager withActiveCards: {}.
	
]

{ #category : 'accessing' }
Game >> locateSpaceShip: nameOfSpaceship [

	^ships locateSpaceShip: nameOfSpaceship in: board 
]

{ #category : 'accessing' }
Game >> locateWinningSpaceShip [

	^ ships locateWinningSpaceShipIn: board
]

{ #category : 'behaviour' }
Game >> nextPlayerThrowsDice [

	| amountToAdvance |
	ships validateIfGameIsOverInsideBoard: board.

	amountToAdvance := cards
		                   applyPermanentEffectOn: ships shipInTurn
		                   overThrow: dicePool throw.

	ships shipInTurnMoves: amountToAdvance inside: board
]

{ #category : 'behaviour' }
Game >> nextPlayerThrowsDiceAndUsesPermanentCard: aCard [

	| amountToAdvance |
	ships validateIfGameIsOverInsideBoard: board.

	cards addPermanentCard: aCard from: ships shipInTurn.

	amountToAdvance := cards
		                   applyPermanentEffectOn: ships shipInTurn
		                   overThrow: dicePool throw.

	ships shipInTurnMoves: amountToAdvance inside: board
]

{ #category : 'behaviour' }
Game >> ranking [
        ^ ships ranking
]
