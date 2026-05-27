Class {
	#name : 'SpaceShipTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipTest >> test001ShipStartsInPositon1 [
| ship |

	ship := Spaceship withName: 'ship1'.
	self assert: ship position equals: 1 .
]

{ #category : 'tests' }
SpaceShipTest >> test002ShipMovesWhenToldTo [

	| ship shipNewPosition |
	ship := Spaceship withName: 'Ship1'.
	shipNewPosition := ship movesForward: 3.
	self assert: shipNewPosition position equals: 4
]

{ #category : 'tests' }
SpaceShipTest >> test003ShipMovesBackwardWhenToldTo [

	| ship shipNewPosition |
	ship := Spaceship withName: 'Ship1' andPosition: 15.
	shipNewPosition := ship movesBackward: 5 .
	self assert: shipNewPosition position equals: 10
]

{ #category : 'tests' }
SpaceShipTest >> test004shipIsValidOnlyWithNameAsText [

	self
		should: [ Spaceship withName: 123 ]
		raiseErrorWithMessageText: 'Name of spaceship must be a string'
]
