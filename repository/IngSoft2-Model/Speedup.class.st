Class {
	#name : 'Speedup',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
Speedup >> applyEffectToShip: certainShip inGame: aGame [

	aGame moveShip: certainShip forward: 4
]

{ #category : 'behavior' }
Speedup >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]
