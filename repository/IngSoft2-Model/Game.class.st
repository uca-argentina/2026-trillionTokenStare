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

{ #category : 'accessing - editing state' }
Game >> addPermanentCard: aCard [

	^ cards addPermanentCard: aCard from: ships shipInTurn
]

{ #category : 'accessing - editing state' }
Game >> applyEffectsOf: actualShip [

	board applyEffectsOf: actualShip inGame: self
]

{ #category : 'accessing - editing state' }
Game >> cancelCard: cardToCancel [

	cards cancel: cardToCancel
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
	
	currentCard applyInstantEffectOnGame: self 
]

{ #category : 'accessing' }
Game >> locateSpaceShip: nameOfSpaceship [

	^ships spaceShipAsDictionary: nameOfSpaceship in: board 
]

{ #category : 'accessing' }
Game >> locateWinningSpaceShip [

	^ ships winningSpaceShipAsDictionaryIn: board
]

{ #category : 'accessing - editing state' }
Game >> moveAllShipsBut: certainShip backward: anAmount [

	ships moveAllShipsBut: certainShip backward: anAmount
]

{ #category : 'accessing - editing state' }
Game >> moveAllShipsToPosition: position [

	ships moveAllShipsToPosition: position inBoard: board
]

{ #category : 'accessing - editing state' }
Game >> moveShip: certainShip backward: anAmount [

	ships moveShip: certainShip backward: anAmount
]

{ #category : 'accessing - editing state' }
Game >> moveShip: certainShip forward: anAmount [

	ships moveShip: certainShip forward: anAmount
]

{ #category : 'accessing' }
Game >> ranking [

	^ ships ranking
]

{ #category : 'accessing - editing state' }
Game >> repeatCardEffectForShipNamed: shipName orCardToCancel: cardToCancel [

	lastCardPlayed
		redoCardWithShipThatReceivesEffect: shipName
		orCardToCancel: cardToCancel
		andGame: self
]

{ #category : 'accessing - editing state' }
Game >> repeatLastEffectsOn: actualShip [

	board repeatLastEffectsOn: actualShip inGame: self
]

{ #category : 'accessing - editing state' }
Game >> repeatSquareEffectForShipNamed: shipName [

	ships shipNamed: shipName repeatsEffectinsGame: self
]

{ #category : 'accessing - editing state' }
Game >> setLastPlayedCard: aCard [

	lastCardPlayed := aCard
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
	
	ships shipInTurnMoves: amountToAdvance inGame: self
]

{ #category : 'behaviour' }
Game >> throwDicePermanentCardNextTurn: aCard [

	| amountToAdvance currentCard |
	ships validateIfGameIsOverInsideBoard: board.

	currentCard := self addPermanentCard: aCard.

	currentCard setAsLastPlayedCardOnGame: self.

	amountToAdvance := cards
		                   applyPermanentEffectOnShip: ships shipInTurn
		                   overThrow: dicePool throw.

	ships shipInTurnMoves: amountToAdvance inGame: self
]
