Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dicePool',
		'board',
		'cards',
		'lastCardPlayed',
		'deck'
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
Game class >> withBoard: aBoard andShips: listOfShips andDicePool: aDicePool andDeck: aDeck [
	"andLaps: numberOfLaps andParsecs: parsecs"

	self validateNumberOfShips: listOfShips.
	self validateDicePool: aDicePool.

	^ self new
		  initializeUsingBoard: aBoard
		  andShips: listOfShips
		  andDicePool: aDicePool
		  andDeck: aDeck 
]

{ #category : 'accessing' }
Game >> board [

	^ board
]

{ #category : 'accessing' }
Game >> cards [

	^ cards
]

{ #category : 'accessing' }
Game >> deck [

	^ deck
]

{ #category : 'initialization' }
Game >> initializeUsingBoard: aBoard andShips: listOfShips andDicePool: aDicePool andDeck: aDeck [

	board := aBoard.
	ships := SpaceshipManager withSpaceships: listOfShips.
	dicePool := aDicePool.
	cards := CardManager withActiveCards: {  }.
	lastCardPlayed := Card new.

	deck := aDeck.
	ships giveTwoCardsToEachSpaceship: deck
]

{ #category : 'behaviour' }
Game >> instantCard: aCard from: nameOfPlayer [

	| currentCard |
	ships validateIfGameIsOverInsideBoard: board.

	currentCard := (ships locateSpaceShip: nameOfPlayer) playCard: aCard.

	currentCard isRedo ifFalse: [ lastCardPlayed := currentCard ].
	
	currentCard applyInstantEffectOnGame: self "apply effect on game"
	"currentCard
		withBoard: board;
		withCardManager: cards;
		withSpaceships: ships;
		withLastCardPlayed: lastCardPlayed ;
		applyInstantEffect"
]

{ #category : 'accessing' }
Game >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : 'accessing' }
Game >> locateSpaceShip: nameOfSpaceship [

	^ships spaceShipAsDictionary: nameOfSpaceship in: board 
]

{ #category : 'accessing' }
Game >> locateWinningSpaceShip [

	^ ships winningSpaceShipAsDictionaryIn: board
]

{ #category : 'accessing' }
Game >> ranking [

	^ ships ranking
]

{ #category : 'accessing' }
Game >> ships [

	^ ships
]

{ #category : 'behaviour' }
Game >> throwDiceNextTurn [

	| amountToAdvance |
	ships validateIfGameIsOverInsideBoard: board.

	amountToAdvance := cards
		                   applyPermanentEffectOnShip: ships shipInTurn
		                   overThrow: dicePool throw.

	ships shipInTurnMoves: amountToAdvance inside: board
]

{ #category : 'behaviour' }
Game >> throwDicePermanentCardNextTurn: aCard [

	| amountToAdvance currentCard |
	ships validateIfGameIsOverInsideBoard: board.

	currentCard := cards addPermanentCard: aCard from: ships shipInTurn.
	
	currentCard isRedo ifFalse: [ lastCardPlayed := currentCard ].

	amountToAdvance := cards
		                   applyPermanentEffectOnShip: ships shipInTurn
		                   overThrow: dicePool throw.

	ships shipInTurnMoves: amountToAdvance inside: board
]
