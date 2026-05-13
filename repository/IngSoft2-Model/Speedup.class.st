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
Speedup class >> onBoardSize: aBoardSize [

	^ self new initializeOnBoardWith: aBoardSize
]

{ #category : 'as yet unclassified' }
Speedup >> applyEffectTo: aShip [

	^ aShip movesForward: 4 until: boardSize
]

{ #category : 'as yet unclassified' }
Speedup >> initializeOnBoardWith: aBoardSize [

boardSize := aBoardSize 
]
