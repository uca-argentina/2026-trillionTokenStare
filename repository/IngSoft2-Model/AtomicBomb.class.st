Class {
	#name : 'AtomicBomb',
	#superclass : 'Square',
	#instVars : [
		'boardSize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBomb >> applyEffectToShip: certainShip inGame: aGame [

	aGame moveAllShipsToPosition: 1
]

{ #category : 'behavior' }
AtomicBomb >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]
