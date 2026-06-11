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

	| ship board shipNewPosition |
	ship := (Spaceship withName: 'Ship1') movesForward: 14.
	board := MockBoardBuilder new build.

	shipNewPosition := ship movesBackward: 3.
	self assert: shipNewPosition position equals: 12
]

{ #category : 'tests' }
SpaceShipTest >> test004shipIsValidOnlyWithNameAsText [

	self
		should: [ Spaceship withName: 123 ]
		raiseErrorWithMessageText: 'Name of spaceship must be a string'
]

{ #category : 'tests' }
SpaceShipTest >> test005SpaceshipPresentsItselfAsDictionaryWithInformation [

	| ship board |
	ship := (Spaceship withName: 'Ship1') movesForward: 14.
	board := MockBoardBuilder new build.

	self assertDictionary: (ship asDictionaryInBoard: board) contains: {
			(#name -> 'Ship1').
			(#position -> 5).
			(#lap -> 2) } asDictionary
]

{ #category : 'tests' }
SpaceShipTest >> test006ShipMovesToCertainPositionRelativeToBoardWithoutChaingingLap [

	| ship board updatedShip |
	ship := (Spaceship withName: 'Ship1') movesForward: 14.
	board := MockBoardBuilder new build.

	updatedShip := ship movesToPosition: 1 InBoard: board.

	self assertDictionary: (updatedShip asDictionaryInBoard: board) contains: {
			(#name -> 'Ship1').
			(#position -> 1).
			(#lap -> 2) } asDictionary
]

{ #category : 'tests' }
SpaceShipTest >> test007SpaceshipReceivesCardAndCanPlayIt [

	| ships cardExpected |
	ships := {
		         (Spaceship withName: 'Ship1') receivesCard: Speed new.
		         (Spaceship withName: 'Ship2') }.

	cardExpected := ships first playCard:
		                (Speed new affectsShipWithName: 'Ship1').

	self assert: cardExpected equals: Speed new
]

{ #category : 'tests' }
SpaceShipTest >> test008shipsTriesToPlayCardThatDoesntPosess [

	| ships |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	self
		should: [
		ships first playCard: (Overload new affectsShipWithName: 'Ship2') ]
		raiseErrorWithMessageText:
		'Ship can not play a card that doesnt posess'
]

{ #category : 'tests' }
SpaceShipTest >> test010ShipRunsOutOfCards [

	| ships |
	ships := { (Spaceship withName: 'Ship1') }.
	
	ships first receivesCard: Card new.
	ships first receivesCard: Card new.

	self
		should: [ 3 timesRepeat: [ ships first playCard: Card new ] ]
		raiseErrorWithMessageText:
		'Ship can not play a card that doesnt posess'
]
