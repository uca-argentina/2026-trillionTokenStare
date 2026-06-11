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
		assert: (shipManager locateSpaceShip: 'one')
		equals: (Spaceship withName: 'one' andPosition: 1).
	self
		assert: (shipManager locateSpaceShip: 'two')
		equals: (Spaceship withName: 'two' andPosition: 1)
]

{ #category : 'tests' }
SpaceshipManagerTest >> test002CantAccessShipThatDoestnExist [

	| shipManager |
	shipManager := SpaceshipManager withSpaceships: {
			               (Spaceship withName: 'one').
			               (Spaceship withName: 'two') }.

	self
		should: [ shipManager locateSpaceShip: 'three' ]
		raiseErrorWithMessageText: 'This spaceship does not exist'
]

{ #category : 'tests' }
SpaceshipManagerTest >> test007managerProvidesDescriptionOfShipAsDictionary [

	| shipManager board |
	shipManager := SpaceshipManager withSpaceships: {
			               (Spaceship withName: 'one' andPosition: 5).
			               (Spaceship withName: 'two' andPosition: 12) }.
	board := MockBoardBuilder new
		         withSquares: 10;
		         withLaps: 2;
		         build.

	self
		assert: (shipManager spaceShipAsDictionary: 'one' in: board)
		equals: {
				(#name -> 'one').
				(#position -> 5).
				(#lap -> 1) } asDictionary.
	self
		assert: (shipManager spaceShipAsDictionary: 'two' in: board)
		equals: {
				(#name -> 'two').
				(#position -> 2).
				(#lap -> 2) } asDictionary.
]

{ #category : 'tests' }
SpaceshipManagerTest >> test008AskingForWinningSpaceshipWhenGameIsNotOver [

	| shipManager board |
	shipManager := SpaceshipManager withSpaceships: {
			               (Spaceship withName: 'one' andPosition: 5).
			               (Spaceship withName: 'two' andPosition: 1) }.
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
			               (Spaceship withName: 'one' andPosition: 5).
			               (Spaceship withName: 'two' andPosition: 11) }.
	board := MockBoardBuilder new
		         withSquares: 10;
		         withLaps: 1;
		         build.

	self
		assert: (shipManager winningSpaceShipAsDictionaryIn: board)
		equals: {
				(#name -> 'two').
				(#position -> 1).
				(#lap -> 2) } asDictionary.
]
