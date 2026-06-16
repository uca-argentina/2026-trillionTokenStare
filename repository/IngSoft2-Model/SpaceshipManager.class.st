Class {
	#name : 'SpaceshipManager',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'playersTurn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceshipManager class >> withSpaceships: _ships [

	^ self new initializeWithShips: _ships
]

{ #category : 'behavior' }
SpaceshipManager >> giveTwoCardsToEachSpaceship: deck [
	ships := ships collect: [ :aShip |
		(aShip receivesCard: deck drawCard) receivesCard: deck drawCard
	]
   
]

{ #category : 'initialization' }
SpaceshipManager >> initializeWithShips: _ships [

	ships := _ships.
	playersTurn := 1
]

{ #category : 'accessing - editing state' }
SpaceshipManager >> moveAllShipsBut: certainShip backward: ammount [

	ships := ships collect: [ :ship |
		ship = certainShip 
		   ifFalse: [ ship movesBackward: ammount ]
		   ifTrue: [ ship ] 
		]
]

{ #category : 'accessing - editing state' }
SpaceshipManager >> moveAllShipsToPosition: position inBoard: aBoard [

	ships := ships collect: [ :ship | ship movesToPosition: position InBoard: aBoard ]
	
]

{ #category : 'accessing - editing state' }
SpaceshipManager >> moveShip: certainShip backward: ammount [

	ships := ships collect: [ :ship |
		ship = certainShip 
		   ifTrue: [ ship movesBackward: ammount ]
		   ifFalse: [ ship ] 
		]
]

{ #category : 'accessing - editing state' }
SpaceshipManager >> moveShip: certainShip forward: ammount [

	ships := ships collect: [ :ship |
		ship = certainShip 
		   ifTrue: [ ship movesForward: ammount ]
		   ifFalse: [ ship ] 
		]
]

{ #category : 'accessing' }
SpaceshipManager >> ranking [

	^ Ranking new bestThreeSpaceShips: ships asOrderedCollection
]

{ #category : 'accessing - editing state' }
SpaceshipManager >> ship: certainShip drawsCardFromDeck: deck [

	ships := ships collect: [ :aShip |
		aShip = certainShip 
		   ifTrue: [ aShip receivesCard: deck drawCard ]
	      ifFalse: [ aShip ]
	]
]

{ #category : 'accessing' }
SpaceshipManager >> shipInTurn [

	^ ships at: playersTurn
]

{ #category : 'behavior' }
SpaceshipManager >> shipInTurnMoves: amountToAdvance inGame: aGame [

	self moveShip: self shipInTurn forward: amountToAdvance.
	aGame applyEffectsOf: self shipInTurn.
	playersTurn := playersTurn % ships size + 1
]

{ #category : 'behavior' }
SpaceshipManager >> shipNamed: playersName repeatsEffectInGame: aGame [

	| ship |
	ship := self spaceshipNamed: playersName.
	
	aGame repeatLastEffectsOn: ship
]

{ #category : 'accessing' }
SpaceshipManager >> spaceShipWithCardsAsDictionary: nameOfSpaceship in: board [

	^ (self spaceshipNamed: nameOfSpaceship)
		  asDictionaryInBoard: board
]

{ #category : 'accessing' }
SpaceshipManager >> spaceshipNamed: nameOfSpaceship [ 

	^ (ships
		   detect: [ :ship | ship name = nameOfSpaceship ]
		   ifNone: [ self error: 'Ship not found.' ])
]

{ #category : 'validation' }
SpaceshipManager >> validateIfGameIsOverInsideBoard: board [

	| outside |
	outside := ships anySatisfy: [ :ship |
		           (board shipInsideBoard: ship) not ].
	outside ifTrue: [ self error: 'Game is over, no more turns allowed' ]
]

{ #category : 'as yet unclassified' }
SpaceshipManager >> validatePlayerHasTurn: aShipName [ 
	(self shipInTurn name = aShipName)
	   ifFalse: [ self error: 'The player must have a turn in the game to use a permanent card' ]
]

{ #category : 'accessing' }
SpaceshipManager >> winningSpaceShipAsDictionaryIn: board [

	^ (ships
		   detect: [ :aShip | (board shipInsideBoard: aShip) not ]
		   ifNone: [ self error: 'Game is not over' ]) asDictionaryInBoard: 
		  board
]
