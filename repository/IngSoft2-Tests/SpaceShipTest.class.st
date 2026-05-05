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
| ship |

	ship := Spaceship withName: 'Ship1'.
	ship moves: 3 until: 10. 
	self assert: ship position equals: 4 .
]

{ #category : 'tests' }
SpaceShipTest >> test003WhenSipMovesOutsideOfRangeThenItDefaultsItsPositionToRange [
| ship |

	ship := Spaceship withName: 'Ship1'.
	ship moves: 12 until: 10. 
	self assert: ship position equals: 10 .
]
