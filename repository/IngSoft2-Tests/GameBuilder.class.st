Class {
	#name : 'GameBuilder',
	#superclass : 'Object',
	#instVars : [
		'laps',
		'parsecs',
		'squarePool',
		'ships',
		'dicePool'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
GameBuilder >> build [

	^ Game
		  withSquarePool: squarePool
		  andShips: ships
		  andDicePool: dicePool
		  andLaps: laps
		  andParsecs: parsecs
]

{ #category : 'initialization' }
GameBuilder >> initialize [

	super initialize.
	laps := 1.
	parsecs := 1000.
	squarePool := SquarePool defaultProbabilitiesWithSize: 10.
	dicePool := DicePool withDice: { (Dice withSides: 4) }.
	ships := {
		         (Spaceship withName: '1').
		         (Spaceship withName: '1') }
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
GameBuilder >> withSquarepool: _squarePool [

	squarePool := _squarePool.
	^ self
]
