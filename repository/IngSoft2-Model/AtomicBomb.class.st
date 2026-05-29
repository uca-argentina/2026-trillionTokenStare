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
AtomicBomb >> applyEffectTo: aShip in: aBoard withCondition: aCondition [

	^ aShip movesToPosition: 1 InBoard: aBoard
]

{ #category : 'as yet unclassified' }
AtomicBomb >> noEffect [

^ false
]
