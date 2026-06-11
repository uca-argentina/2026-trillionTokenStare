Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
Wormhole >> applyEffectToShip: certainShip inGame: aGame [

	aGame moveShip: certainShip backward: 4
]

{ #category : 'behavior' }
Wormhole >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]
