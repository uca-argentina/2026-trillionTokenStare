Class {
	#name : 'AtomicBomb',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
AtomicBomb >> applyEffectToShip: certainShip inGame: aGame [

	aGame moveAllShipsToPosition: 1
]

{ #category : 'behavior' }
AtomicBomb >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]
