Class {
	#name : 'Acceleration',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Acceleration >> = aCard [

	^ self class = aCard class
]

{ #category : 'initialization' }
Acceleration >> applyEffectOn: aShip overThrow: aThrow [

	^ aThrow + 1
]
