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
Speedup >> applyEffectTo: aShip [

	^ aShip movesForward: 4
]
