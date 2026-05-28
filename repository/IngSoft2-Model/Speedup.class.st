Class {
	#name : 'Speedup',
	#superclass : 'Square',
	#instVars : [
		'boardSize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Speedup >> applyEffectRegardlesOfPositionTo: aShip in: aBoard [

	^ aShip movesForward: 4
]

{ #category : 'as yet unclassified' }
Speedup >> applyEffectTo: aShip in: aBoard [

	(aShip positionInBoard: aBoard) = number ifTrue: [
		^ aShip movesForward: 4 ].
	^ aShip
]
