Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'position',
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Square >> = aSquareClass [

	^ aSquareClass = self class
]

{ #category : 'behavior' }
Square >> applyEffectToShip: certainShip inGame: aGame [

	
]

{ #category : 'accessing' }
Square >> atPosition: squarePosition [

	position := squarePosition.

	^ self
]

{ #category : 'initialization' }
Square >> initialize [

	super initialize.
	position := 1.
	parsecs := 1.
	
	^ self
]

{ #category : 'accessing' }
Square >> parsecs [

	^ parsecs 
]

{ #category : 'accessing' }
Square >> position [

	^ position
]

{ #category : 'behavior' }
Square >> setLastEffectIn: aBoard [
]

{ #category : 'accessing' }
Square >> withParsecs: _parsecs [

	parsecs := _parsecs.

	^ self
]
