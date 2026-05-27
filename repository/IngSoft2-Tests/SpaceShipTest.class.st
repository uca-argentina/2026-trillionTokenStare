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
SpaceShipTest >> test002ShipMovesForwardWhenToldTo [

	| ship shipNewPosition |
	ship := Spaceship withName: 'Ship1'.
	shipNewPosition := ship movesForward: 3.
	self assert: shipNewPosition position equals: 4
]

{ #category : 'tests' }
SpaceShipTest >> test003ShipMovesBackwardWhenToldTo [

	| ship shipNewPosition board |
	ship := Spaceship withName: 'Ship1' andPosition: 15.
	board := MockBoardBuilder new build
]

{ #category : 'tests' }
SpaceShipTest >> test004shipIsValidOnlyWithNameAsText [

	self
		should: [ Spaceship withName: 123 ]
		raiseErrorWithMessageText: 'Name of spaceship must be a string'
]

{ #category : 'tests' }
SpaceShipTest >> test005shiPpresentsItselfAsDictionaryWithInformation [

	| ship board |
	ship := Spaceship withName: 'Ship1' andPosition: 15.
	board := MockBoardBuilder new build.

	self assert: (ship asDictionaryInBoard: board) equals: {
			(#name -> 'Ship1').
			(#position -> 5).
			(#lap -> 2) } asDictionary
]

{ #category : 'tests' }
SpaceShipTest >> test006ShipMovesToCertainPositionRelativeToBoardWithoutChaingingLap [

	| ship board updatedShip |
	ship := Spaceship withName: 'Ship1' andPosition: 15.
	board := MockBoardBuilder new build.

	updatedShip := ship movesToPosition: 1 InBoard: board.

	self assert: (updatedShip asDictionaryInBoard: board) equals: {
			(#name -> 'Ship1').
			(#position -> 1).
			(#lap -> 2) } asDictionary
]
