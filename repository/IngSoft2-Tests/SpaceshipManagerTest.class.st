Class {
	#name : 'SpaceshipManagerTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceshipManagerTest >> test001SpaceShipManagerReceivesListOfShipsAndCanAccesEachShipIndividually [

	| shipManager |
	shipManager := SpaceshipManager withSpaceships: {
			               (Spaceship withName: 'one').
			               (Spaceship withName: 'two') }.

	self
		assert: (shipManager spaceshipNamed: 'one')
		equals: (Spaceship withName: 'one' ).
	self
		assert: (shipManager spaceshipNamed: 'two')
		equals: (Spaceship withName: 'two' )
]

{ #category : 'tests' }
SpaceshipManagerTest >> test002CantAccessShipThatDoestnExist [

	| shipManager |
	shipManager := SpaceshipManager withSpaceships: {
			               (Spaceship withName: 'one').
			               (Spaceship withName: 'two') }.

	self
		should: [ shipManager spaceshipNamed: 'three' ]
		raiseErrorWithMessageText: 'Ship not found.'
]

{ #category : 'tests' }
SpaceshipManagerTest >> test007managerProvidesDescriptionOfShipAsDictionary [

	| shipManager board |
	shipManager := SpaceshipManager withSpaceships: {
			               ((Spaceship withName: 'one') movesForward: 4).
			               ((Spaceship withName: 'two') movesForward: 11) }.
	board := MockBoardBuilder new
		         withSquares: 10;
		         withLaps: 2;
		         build.

	self
		assertDictionary:
		(shipManager spaceShipWithCardsAsDictionary: 'one' in: board)
		contains: {
				(#name -> 'one').
				(#position -> 5).
				(#lap -> 1) } asDictionary.
	self
		assertDictionary:
		(shipManager spaceShipWithCardsAsDictionary: 'two' in: board)
		contains: {
				(#name -> 'two').
				(#position -> 2).
				(#lap -> 2) } asDictionary
]

{ #category : 'tests' }
SpaceshipManagerTest >> test008AskingForWinningSpaceshipWhenGameIsNotOver [

	| shipManager board |
	shipManager := SpaceshipManager withSpaceships: {
			               ((Spaceship withName: 'one') movesForward: 4).
			               ((Spaceship withName: 'two') movesForward: 1) }.
	board := MockBoardBuilder new
		         withSquares: 10;
		         withLaps: 1;
		         build.

	self
		should: [ shipManager winningSpaceShipAsDictionaryIn: board ]
		raiseErrorWithMessageText: 'Game is not over'
]

{ #category : 'tests' }
SpaceshipManagerTest >> test009AskingForWinningSpaceShip [

	| shipManager board |
	shipManager := SpaceshipManager withSpaceships: {
			               ((Spaceship withName: 'one') movesForward: 4).
			               ((Spaceship withName: 'two') movesForward: 10) }.
	board := MockBoardBuilder new
		         withSquares: 10;
		         withLaps: 1;
		         build.

	self
		assertDictionary:
		(shipManager winningSpaceShipAsDictionaryIn: board)
		contains: {
				(#name -> 'two').
				(#position -> 1).
				(#lap -> 2) } asDictionary
]
