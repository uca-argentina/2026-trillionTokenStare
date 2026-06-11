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

	aGame moveAllShipsBut: certainShip backward: backtrack
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

{ #category : 'behavior' }
Moonwalk >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]

{ #category : 'initialization' }
Moonwalk >> withBacktrack: aBacktrack [
	backtrack := aBacktrack.

	^ self
]
