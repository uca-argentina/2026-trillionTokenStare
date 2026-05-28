Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardManager >> applyEffectOn: aShip overThrow: aThrow [

	| resultingThrow |
	resultingThrow := aThrow.

	activeCards do: [ :card |
		resultingThrow := card
			                  applyEffectOn: aShip
			                  overThrow: resultingThrow ].
	^ resultingThrow
]

{ #category : 'initialization' }
CardManager >> initialize [

	super initialize.
	^ self
]

{ #category : 'initialization' }
CardManager >> withActiveCards: _activeCards [

	activeCards := _activeCards.
	^ self
]
