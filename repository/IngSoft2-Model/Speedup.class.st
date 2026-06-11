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
Speedup >> applyEffectToShip: certainShip inGame: aGame [

	aGame ships moveShip: certainShip forward: 4

	"aCondition ifTrue: [
		^ aShip movesForward: 4 ].
	^ aShip"
]

{ #category : 'as yet unclassified' }
Speedup >> noEffect [

^ false
]
