Class {
	#name : 'CardDropper',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
CardDropper >> applyEffectToShip: certainShip inGame: aGame [

	aGame cardsDrawnByShip: certainShip
]

{ #category : 'behavior' }
CardDropper >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]
