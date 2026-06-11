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
Game >> activeCards [

	^ cards permanentCards 
]

{ #category : 'delegating' }
Game >> addPermanentCard: aCard [

	self setLastPlayedCard: aCard.
	cards addPermanentCard: aCard from: ships shipInTurn
]

{ #category : 'delegating' }
Game >> addPermanentCardDirectly: aCard [

	self setLastPlayedCard: aCard.
	cards addPermanentCardDirectly: aCard
]

{ #category : 'delegating' }
Game >> applyEffectsOf: actualShip [

	board applyEffectsOf: actualShip inGame: self
]

{ #category : 'delegating' }
Game >> cancelCard: cardToCancel [

	cards cancel: cardToCancel
]

{ #category : 'delegating' }
Game >> cardsDrawnByShip: certainShip [

	ships ship: certainShip drawsCardFromDeck: deck
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

	currentCard := (ships spaceshipNamed: nameOfPlayer) playCard: aCard.
	
	currentCard applyInstantEffectOnGame: self 
]

{ #category : 'delegating' }
Game >> moveAllShipsBut: certainShip backward: anAmount [

	ships moveAllShipsBut: certainShip backward: anAmount
]

{ #category : 'delegating' }
Game >> moveAllShipsToPosition: position [

	ships moveAllShipsToPosition: position inBoard: board
]

{ #category : 'delegating' }
Game >> moveShip: certainShip backward: anAmount [

	ships moveShip: certainShip backward: anAmount
]

{ #category : 'delegating' }
Game >> moveShip: certainShip forward: anAmount [

	ships moveShip: certainShip forward: anAmount
]

{ #category : 'accessing' }
Game >> ranking [

	^ ships ranking
]

{ #category : 'delegating' }
Game >> repeatCardEffectForShipNamed: shipName orCardToCancel: cardToCancel [

	lastCardPlayed
		redoCardWithShipThatReceivesEffect: shipName
		orCardToCancel: cardToCancel
		andGame: self
]

{ #category : 'delegating' }
Game >> repeatLastEffectsOn: actualShip [

	board repeatLastEffectsOn: actualShip inGame: self
]

{ #category : 'delegating' }
Game >> repeatSquareEffectForShipNamed: shipName [

	ships shipNamed: shipName repeatsEffectInGame: self
]

{ #category : 'changing state' }
Game >> setLastPlayedCard: aCard [

	lastCardPlayed := aCard
]

{ #category : 'accessing' }
Game >> spaceshipNamed: nameOfSpaceship [

	^ ships spaceShipWithCardsAsDictionary: nameOfSpaceship in: board
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

	| amountToAdvance |
	ships validateIfGameIsOverInsideBoard: board.

	self addPermanentCard: aCard.

	amountToAdvance := cards
		                   applyPermanentEffectOnShip: ships shipInTurn
		                   overThrow: dicePool throw.

	ships shipInTurnMoves: amountToAdvance inGame: self
]

{ #category : 'accessing' }
Game >> winningSpaceship [

	^ ships winningSpaceShipAsDictionaryIn: board
]
