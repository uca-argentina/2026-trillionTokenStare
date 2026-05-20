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

{ #category : 'accessing' }
Square class >> defaultAt: squareNumber andParsecs: parsecs [

	^ self new initializeAt: squareNumber andParsecs: parsecs
]

{ #category : 'accessing' }
Square class >> randomAt: squareNumber andParsecs: parsecs [
        ^ self defaultAt: squareNumber andParsecs: parsecs
]

{ #category : 'comparing' }
Square >> = aSquareClass [

	^ aSquareClass = self class
]

{ #category : 'as yet unclassified' }
Square >> applyEffectTo: aShip [

	^ aShip
]

{ #category : 'accessing' }
Square >> initializeAt: squareNumber andParsecs: numberOfParsecs [

	number := squareNumber.
	parsecs := numberOfParsecs
]
