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
	squarePool := MockSquarePool withPreloadedSquares:
		              ((1 to: 10) collect: [ :i | Square ]).
	dicePool := DicePool withDice: { (Dice withSides: 4) }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }
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

{ #category : 'as yet unclassified' }
GameBuilder >> withSquares: _squareAmmount [

	squarePool := MockSquarePool withPreloadedSquares:
		              ((1 to: _squareAmmount) collect: [ :i | Square ]).
	^ self
]
