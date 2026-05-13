Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Wormhole >> applyEffectTo: aShip [

	^ aShip movesBackward: 4
]
