Class {
	#name : 'Moonwalk',
	#superclass : 'Square',
	#instVars : [
		'backtrack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Moonwalk >> applyEffectRegardlesOfPositionTo: aShip in: aBoard [

	(aShip positionInBoard: aBoard) = number ifTrue: [ ^ aShip ].
	^ aShip movesBackward: backtrack
]

{ #category : 'as yet unclassified' }
Moonwalk >> applyEffectTo: aShip in: aBoard [

	(aShip positionInBoard: aBoard) = number ifTrue: [ ^ aShip ].
	^ aShip movesBackward: backtrack
]

{ #category : 'accessing' }
Moonwalk >> backtrack [
        ^ backtrack
]

{ #category : 'initialization' }
Moonwalk >> initialize [

	super initialize.
	backtrack := 3.
	number := 1.
	parsecs := 1.

	^ self
]

{ #category : 'initialization' }
Moonwalk >> withBacktrack: aBacktrack [
	backtrack := aBacktrack.

	^ self
]
