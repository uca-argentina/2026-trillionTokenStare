Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Card >> = aCard [

	^ self class = aCard class
]

{ #category : 'behavior' }
Card >> applyInstantEffectOnGame: aGame [

	self error: 'Not an instant effect card'
]

{ #category : 'behavior' }
Card >> applyPermanentEffectOnShip: aShip overThrow: aThrow [

	self error: 'Not a permanent effect card.'
]

{ #category : 'initialization' }
Card >> initialize [

	super initialize.
	^ self
]

{ #category : 'comparing' }
Card >> isInstantCard [

^false
]

{ #category : 'comparing' }
Card >> isPermanentCard [

^false
]

{ #category : 'comparing' }
Card >> isRedo [

^false
]
