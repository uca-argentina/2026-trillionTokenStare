Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'number',
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Square >> = aSquareClass [

	^ aSquareClass = self class
]

{ #category : 'as yet unclassified' }
Square >> applyEffectTo: aShip in: aBoard [

	^ aShip
]

{ #category : 'as yet unclassified' }
Square >> applyEffectTo: aShip in: aBoard withCondition: aCondition [

	^ aShip
]

{ #category : 'accessing' }
Square >> atPosition: squareNumber [

	number := squareNumber.

	^ self
]

{ #category : 'accessing' }
Square >> initialize [

	super initialize.
	number := 1.
	parsecs := 1.
	
	^ self
]

{ #category : 'as yet unclassified' }
Square >> noEffect [

^ true
]

{ #category : 'accessing' }
Square >> parsecs [

	^ parsecs 
]

{ #category : 'accessing' }
Square >> position [

	^ number
]

{ #category : 'accessing' }
Square >> withParsecs: _parsecs [

	parsecs := _parsecs.

	^ self
]
