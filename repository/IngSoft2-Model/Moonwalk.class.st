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
Moonwalk >> applyEffectToShip: certainShip inGame: aGame [

	aGame ships moveAllShipsBut: certainShip backward: backtrack 

	"aCondition ifTrue: [ ^ aShip ].
	^ aShip movesBackward: backtrack"
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

{ #category : 'as yet unclassified' }
Moonwalk >> noEffect [

^ false
]

{ #category : 'initialization' }
Moonwalk >> withBacktrack: aBacktrack [
	backtrack := aBacktrack.

	^ self
]
