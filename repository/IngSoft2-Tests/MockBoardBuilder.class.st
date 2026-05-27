Class {
	#name : 'MockBoardBuilder',
	#superclass : 'Object',
	#instVars : [
		'preloadedEffects',
		'numberOfSquares',
		'laps',
		'parsecs'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialization' }
MockBoardBuilder >> build [

"cada square funciona como un builder

cuando se pasa se debe inicializar con new. el new es default

at: le añade la posicion
parsecs: le añade los parsecs

cualquier otra cosa se añade de la misma forma
"

	| parsecsPerSquare |
	self validateParsecs.
	self validateSquares.
	parsecsPerSquare := parsecs / preloadedEffects size.

	^ Board
		  withSquares:
			  (preloadedEffects withIndexCollect: [ :effect :index |
				   effect atPosition: index; withParsecs: parsecsPerSquare ])
		  andLaps: laps
]

{ #category : 'initialization' }
MockBoardBuilder >> initialize [

	super initialize.
	preloadedEffects := (1 to: 10) collect: [ :i | Square new].
	numberOfSquares := preloadedEffects size.
	laps := 1.
	parsecs := 1000
]

{ #category : 'initialization' }
MockBoardBuilder >> numberOfSquares [

	^ numberOfSquares
]

{ #category : 'vali' }
MockBoardBuilder >> validateParsecs [

	parsecs < 1000 ifTrue: [
		self error: 'The board must have at least 1000 parsecs.' ]
]

{ #category : 'initialization' }
MockBoardBuilder >> validateSquares [

	 numberOfSquares < 1 ifTrue: [
		self error: 'The board must have at least 1 square.' ]
]

{ #category : 'initialization' }
MockBoardBuilder >> withEffects: aListOfPreloadedEffects [

	preloadedEffects := aListOfPreloadedEffects.
	numberOfSquares := aListOfPreloadedEffects size.
	^ self
]

{ #category : 'initialization' }
MockBoardBuilder >> withLaps: _laps [

	laps := _laps .
	^ self
]

{ #category : 'initialization' }
MockBoardBuilder >> withParsecs: _parsecs [

	parsecs := _parsecs.
	^ self
]

{ #category : 'initialization' }
MockBoardBuilder >> withSquares: _numberOfSquares [

	preloadedEffects := (1 to: _numberOfSquares) collect: [ :i | Square new].
	numberOfSquares := _numberOfSquares.
	^ self
]
