Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Wormhole >> applyEffectTo: aShip in: aBoard [

	(aShip positionInBoard: aBoard) = number ifTrue: [
		^ aShip movesBackward: 4 ].
	^ aShip
]

{ #category : 'as yet unclassified' }
Wormhole >> applyEffectTo: aShip in: aBoard withCondition: aCondition [

	aCondition ifTrue: [
		^ aShip movesBackward: 4 ].
	^ aShip
]

{ #category : 'as yet unclassified' }
Wormhole >> noEffect [

^ false
]
