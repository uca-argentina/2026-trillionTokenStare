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
SpaceshipManager >> initializeWithShips: _ships [

	ships := _ships.
	playersTurn := 1
]

{ #category : 'accessing' }
SpaceshipManager >> locateSpaceShip: nameOfSpaceship [

	^ ships
		  detect: [ :ship | ship name = nameOfSpaceship ]
		  ifNone: [ self error: 'This spaceship does not exist' ]
]

{ #category : 'accessing' }
SpaceshipManager >> ranking [

	^ Ranking new bestThreeSpaceShips: ships asOrderedCollection
]

{ #category : 'accessing' }
SpaceshipManager >> shipInTurn [

	^ ships at: playersTurn
]

{ #category : 'behavior' }
SpaceshipManager >> shipInTurnMoves: amountToAdvance inside: board [

	| newShipPosition |
	newShipPosition := self shipInTurn movesForward: amountToAdvance.
	ships at: playersTurn put: newShipPosition.

	(board shipInsideBoard: newShipPosition) ifTrue: [
		ships := board applyEffectsOf: newShipPosition to: ships ].

	playersTurn := playersTurn % ships size + 1
]

{ #category : 'behavior' }
SpaceshipManager >> shipNamed: playersName repeatsEffectinside: board [

	ships := board
		         repeatLastEffectOn:
		         (self locateSpaceShip: playersName )
		         fromShips: ships
]

{ #category : 'accessing' }
SpaceshipManager >> spaceShipAsDictionary: nameOfSpaceship in: board [

	^ (self locateSpaceShip: nameOfSpaceship )
		  asDictionaryInBoard: board
]

{ #category : 'validation' }
SpaceshipManager >> validateIfGameIsOverInsideBoard: board [

	| outside |
	outside := ships anySatisfy: [ :ship |
		           (board shipInsideBoard: ship) not ].
	outside ifTrue: [ self error: 'Game is over, no more turns allowed' ]
]

{ #category : 'accessing' }
SpaceshipManager >> winningSpaceShipAsDictionaryIn: board [

	^ (ships
		   detect: [ :aShip | (board shipInsideBoard: aShip) not ]
		   ifNone: [ self error: 'Game is not over' ]) asDictionaryInBoard:
		  board
]
