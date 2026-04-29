Class {
	#name : 'DiceMock',
	#superclass : 'Object',
	#instVars : [
		'sides',
		'sequence',
		'index'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DiceMock class >> withSides: numberOfSides [

	numberOfSides < 4 ifTrue: [
		self error: 'The dice must have at least 4 sides' ].
	^ self new initializeWithSides: numberOfSides andSequence: #(1)
]

{ #category : 'as yet unclassified' }
DiceMock class >> withSides: numberOfSides andSequence: aSequence [

	numberOfSides < 4 ifTrue: [
		self error: 'The dice must have at least 4 sides' ].
	^ self new initializeWithSides: numberOfSides andSequence: aSequence 
]

{ #category : 'initialization' }
DiceMock >> initializeWithSides: numberOfSides andSequence: aSequence [
	
	sides := numberOfSides.
	sequence := aSequence.
	index:= 1
]

{ #category : 'initialization' }
DiceMock >> throw [

	| value |
	value := sequence at: index.

	self validateThrowIsInsideRange: value.
	self validateThrowIsPositive: value.

	index := index % sequence size + 1.
	^ value
]

{ #category : 'initialization' }
DiceMock >> validateThrowIsInsideRange: value [

	value > sides ifTrue: [
		self error: 'Dice must throw a value less or equal number of sides' ]
]

{ #category : 'initialization' }
DiceMock >> validateThrowIsPositive: value [

	value > 0 ifFalse: [
		self error: 'Dice must throw a value of at least 1' ]
]
