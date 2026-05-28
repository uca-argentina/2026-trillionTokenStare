Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ShipManager class >> withShips: _ships [

	^ self new initializeWithShips: _ships
]

{ #category : 'initialization' }
ShipManager >> initializeWithShips: _ships [

	ships := _ships
]

{ #category : 'initialization' }
ShipManager >> locateSpaceShip: nameOfSpaceship inBoard: board [

	^ (ships
		   detect: [ :ship | ship name = nameOfSpaceship ]
		   ifNone: [ self error: 'This spaceship does not exist' ])
		  asDictionaryInBoard: board
]

{ #category : 'initialization' }
ShipManager >> locateWinningSpaceShipInBoard: board [

	^ (ships
		   detect: [ :aShip | (board shipInsideBoard: aShip) not ]
		   ifNone: [ self error: 'Game is not over' ]) asDictionaryInBoard:
		  board
]

{ #category : 'initialization' }
ShipManager >> ships [

	^ ships
]

{ #category : 'initialization' }
ShipManager >> ships: _ships [

	ships := _ships
]
