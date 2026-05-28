Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
PermanentCard >> = aCard [

	^ self class = aCard class
]

{ #category : 'initialization' }
PermanentCard >> affectsShipWithName: _shipToAffect [

	^ self
]
