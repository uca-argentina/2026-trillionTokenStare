Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'number'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Square class >> defaultAt: squareNumber [

	^ self new initializeAt: squareNumber
]

{ #category : 'as yet unclassified' }
Square >> applyEffectTo: aShip [

	^ aShip
]

{ #category : 'accessing' }
Square >> initializeAt: squareNumber [

	number := squareNumber
]
