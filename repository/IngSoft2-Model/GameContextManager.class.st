Class {
	#name : 'GameContextManager',
	#superclass : 'Object',
	#instVars : [
		'game',
		'board',
		'ships',
		'cards',
		'lastCardPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
GameContextManager class >> withGame: aGame spaceships: aShipsManager cards: aCardManager lastCardPlayed: theLastCardPlayed board: aBoard [

	^ self new
		  initializeWithGame: aGame
		  spaceships: aShipsManager
		  cards: aCardManager
		  lastCardPlayed: theLastCardPlayed
		  board: aBoard
]

{ #category : 'behavior' }
GameContextManager >> activeCards [

	^ game activeCards
]

{ #category : 'behavior' }
GameContextManager >> addPermanentCard: aCard [

	game setLastPlayedCard: aCard.
	cards addPermanentCard: aCard from: ships shipInTurn
]

{ #category : 'behavior' }
GameContextManager >> addPermanentCardDirectly: aCard [

	game setLastPlayedCard: aCard.
	cards addPermanentCardDirectly: aCard
]

{ #category : 'behavior' }
GameContextManager >> applyEffectsOf: actualShip [

	board applyEffectsOf: actualShip inGame: game
]

{ #category : 'behavior' }
GameContextManager >> cancelCard: cardToCancel [

	cards cancel: cardToCancel
]

{ #category : 'behavior' }
GameContextManager >> cardsDrawnByShip: certainShip [

	ships ship: certainShip drawsCardFromDeck: game deck
]

{ #category : 'initialization' }
GameContextManager >> initializeWithGame: aGame spaceships: aShipsManager cards: aCardManager lastCardPlayed: theLastCardPlayed board: aBoard [

	game := aGame.
	ships := aShipsManager.
	cards := aCardManager.
	board := aBoard.
	lastCardPlayed := theLastCardPlayed.
	^ self
]

{ #category : 'behavior' }
GameContextManager >> moveAllShipsBut: certainShip backward: anAmount [

	ships moveAllShipsBut: certainShip backward: anAmount
]

{ #category : 'behavior' }
GameContextManager >> moveAllShipsToPosition: position [

	ships moveAllShipsToPosition: position inBoard: board
]

{ #category : 'behavior' }
GameContextManager >> moveShip: certainShip backward: anAmount [

	ships moveShip: certainShip backward: anAmount
]

{ #category : 'behavior' }
GameContextManager >> moveShip: certainShip forward: anAmount [

	ships moveShip: certainShip forward: anAmount
]

{ #category : 'behavior' }
GameContextManager >> repeatCardEffectForShipNamed: shipName orCardToCancel: cardToCancel [

	lastCardPlayed
		redoCardWithShipThatReceivesEffect: shipName
		orCardToCancel: cardToCancel
		andGame: game
]

{ #category : 'behavior' }
GameContextManager >> repeatLastEffectsOn: actualShip [

	board repeatLastEffectsOn: actualShip inGame: game
]

{ #category : 'behavior' }
GameContextManager >> repeatSquareEffectForShipNamed: shipName [

	ships shipNamed: shipName repeatsEffectInGame: game
]

{ #category : 'behavior' }
GameContextManager >> setLastPlayedCard: aCard [

	game setLastPlayedCard: aCard
]
