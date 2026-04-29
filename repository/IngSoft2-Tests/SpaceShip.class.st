Class {
	#name : 'SpaceShip',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShip >> test001ShipStartsInPositon1 [
| ship |

	ship := Spaceship withName: 'ship1'.
	self assert: ship position equals: 1 .
]

{ #category : 'tests' }
SpaceShip >> test002ShipMovesWhenToldTo [
| ship |

	ship := Spaceship withName: 'Ship1'.
	ship move: 3. 
	self assert: ship position equals: 4 .
]
