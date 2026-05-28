Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Card >> applyEffectOn: aShip overThrow: aThrow [

	self subclassResponsibility
]

{ #category : 'initialization' }
Card >> initialize [

	super initialize.
	^ self
]
