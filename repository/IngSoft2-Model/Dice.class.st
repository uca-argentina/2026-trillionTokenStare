Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'sides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Dice class >> withSides: numberOfSides [

	numberOfSides < 4 ifTrue: [
		self error: 'The dice must have at least 4 sides' ].
	^ self new initializeWithSides: numberOfSides
]

{ #category : 'initialization' }
Dice >> initializeWithSides: numberOfSides [

	sides := numberOfSides
]

{ #category : 'initialization' }
Dice >> throw [

	^ 1
]
