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

{ #category : 'initialization' }
Card >> applyInstantEffect [

	self error: 'Not an instant effect card'
]

{ #category : 'initialization' }
Card >> applyPermanentEffectOn: aShip overThrow: aThrow [

	self error: 'Not a permanent effect card.'
]

{ #category : 'initialization' }
Card >> initialize [

	super initialize.
	^ self
]
