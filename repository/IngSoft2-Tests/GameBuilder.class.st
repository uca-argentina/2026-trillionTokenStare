Class {
	#name : 'GameBuilder',
	#superclass : 'Object',
	#instVars : [
		'laps',
		'parsecs',
		'ships',
		'dicePool',
		'boardBuilder'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
GameBuilder >> build [

	| board |
	board := boardBuilder
		         withLaps: laps;
		         withParsecs: parsecs;
		         build.

	^ Game withBoard: board andShips: ships andDicePool: dicePool
]

{ #category : 'initialization' }
GameBuilder >> initialize [

	super initialize.
	laps := 1.
	parsecs := 1000.
	boardBuilder := MockBoardBuilder new withEffects:
		              ((1 to: 10) collect: [ :i | Square new]).
	dicePool := DicePool withDice: { (Dice withSides: 4) }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }
]

{ #category : 'as yet unclassified' }
GameBuilder >> withBoardBuilder: _boardBuilder [

	boardBuilder := _boardBuilder.
	^ self
]

{ #category : 'as yet unclassified' }
GameBuilder >> withDicepool: _dicepool [

	dicePool := _dicepool .
	^ self
]

{ #category : 'as yet unclassified' }
GameBuilder >> withLaps: _laps [

	laps := _laps.
	^ self
]

{ #category : 'as yet unclassified' }
GameBuilder >> withParsecs: _parsecs [

	parsecs := _parsecs.
	^ self
]

{ #category : 'as yet unclassified' }
GameBuilder >> withSpaceships: _spaceships [

	ships := _spaceships.
	^ self
]

{ #category : 'as yet unclassified' }
GameBuilder >> withSquares: _squareAmmount [

	boardBuilder := MockBoardBuilder new withEffects:
		                ((1 to: _squareAmmount) collect: [ :i | Square new]).
	^ self
]
