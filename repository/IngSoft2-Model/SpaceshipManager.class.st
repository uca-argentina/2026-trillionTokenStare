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

{ #category : 'initialization' }
SpaceshipManager >> SpaceShipAsDictionary: nameOfSpaceship in: board [

	^ (self locateSpaceShip: nameOfSpaceship in: board)
		  asDictionaryInBoard: board
]

{ #category : 'initialization' }
SpaceshipManager >> WinningSpaceShipAsDictionaryIn: board [

	^ (ships
		   detect: [ :aShip | (board shipInsideBoard: aShip) not ]
		   ifNone: [ self error: 'Game is not over' ]) asDictionaryInBoard:
		  board
]

{ #category : 'initialization' }
SpaceshipManager >> advanceTurn [

	playersTurn := playersTurn % ships size + 1
]

{ #category : 'initialization' }
SpaceshipManager >> initializeWithShips: _ships [

	ships := _ships.
	playersTurn := 1
]

{ #category : 'initialization' }
SpaceshipManager >> locateSpaceShip: nameOfSpaceship in: board [

	^ ships
		  detect: [ :ship | ship name = nameOfSpaceship ]
		  ifNone: [ self error: 'This spaceship does not exist' ]
]

{ #category : 'initialization' }
SpaceshipManager >> ranking [

	^ Ranking new bestThreeSpaceShips: ships asOrderedCollection
]

{ #category : 'initialization' }
SpaceshipManager >> shipInTurn [

	^ ships at: playersTurn
]

{ #category : 'initialization' }
SpaceshipManager >> shipInTurnMoves: amountToAdvance inside: board [

	| newShipPosition |
	newShipPosition := self shipInTurn movesForward: amountToAdvance.
	ships at: playersTurn put: newShipPosition.

	(board shipInsideBoard: newShipPosition) ifTrue: [
		ships := board applyEffectsOf: newShipPosition to: ships ].

	self advanceTurn
]

{ #category : 'initialization' }
SpaceshipManager >> shipNamed: playersName repeatsMoveinside: board [

	ships := board
		         repeatLastEffectOn:
		         (self locateSpaceShip: playersName in: board)
		         fromShips: ships
]

{ #category : 'initialization' }
SpaceshipManager >> validateIfGameIsOverInsideBoard: board [

	| outside |
	outside := ships anySatisfy: [ :ship |
		           (board shipInsideBoard: ship) not ].
	outside ifTrue: [ self error: 'Game is over, no more turns allowed' ]
]
