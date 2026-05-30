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

{ #category : 'tests' }
SpaceShipTest >> test007shipsWithCards [

	| ships cardExpected |
	ships := {
		         (Spaceship withName: 'Ship1' andPosition: 1 andCards: {
				          Acceleration new.
				          Speed new }).
		         (Spaceship withName: 'Ship2' andPosition: 1 andCards: {
				          Card new.
				          Overload new }) }.

	cardExpected := ships first playCard:
		                (Speed new affectsShipWithName: 'Ship1').

	self assert: cardExpected equals: Speed new
]

{ #category : 'tests' }
SpaceShipTest >> test008shipsTriesToPlayCardThatDoesntPosess [

	| ships |
	ships := {
		         (Spaceship withName: 'Ship1' andPosition: 1 andCards: {
				          Acceleration new.
				          Speed new }).
		         (Spaceship withName: 'Ship2' andPosition: 1 andCards: {
				          Card new.
				          Overload new }) }.

	self should: [ ships first playCard:
		                (Overload new affectsShipWithName: 'Ship2'). ] raiseErrorWithMessageText: 'Ship can not play a card that doesnt posess'
	

]

{ #category : 'tests' }
SpaceShipTest >> test009shipReceivesCard [

	| ships cardExpected |
	ships := {
		         (Spaceship withName: 'Ship1' andPosition: 1 andCards: {  }).
		         (Spaceship withName: 'Ship2' andPosition: 1 andCards: {  }) }.

	ships first receivesCard: Acceleration new.

	cardExpected := ships first playCard:
		                (Acceleration new).

	self assert: cardExpected equals: Acceleration new
]

{ #category : 'tests' }
SpaceShipTest >> test010ShipRunsOutOfCards [

	| ships |
	ships := { (Spaceship withName: 'Ship1' andPosition: 1 andCards: {
			          Card new.
			          Card new }) }.

	self
		should: [ 3 timesRepeat: [ ships first playCard: Card new ] ]
		raiseErrorWithMessageText:
		'Ship can not play a card that doesnt posess'
]
