Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Wormhole >> applyEffectToShip: certainShip inGame: aGame [

	aGame ships moveShip: certainShip backward: 4

	"aCondition ifTrue: [
		^ aShip movesBackward: 4 ].
	^ aShip"
]

{ #category : 'behavior' }
Wormhole >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]
