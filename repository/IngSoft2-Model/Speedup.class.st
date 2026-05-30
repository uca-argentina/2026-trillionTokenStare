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
Speedup >> applyEffectTo: aShip in: aBoard withCondition: aCondition [

	aCondition ifTrue: [
		^ aShip movesForward: 4 ].
	^ aShip
]

{ #category : 'as yet unclassified' }
Speedup >> noEffect [

^ false
]
