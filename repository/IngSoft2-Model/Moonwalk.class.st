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
Moonwalk >> applyEffectTo: aShip in: aBoard withCondition: aCondition [

	aCondition ifTrue: [ ^ aShip ].
	^ aShip movesBackward: backtrack
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

{ #category : 'as yet unclassified' }
Moonwalk >> noEffect [

^ false
]

{ #category : 'initialization' }
Moonwalk >> withBacktrack: aBacktrack [
	backtrack := aBacktrack.

	^ self
]
