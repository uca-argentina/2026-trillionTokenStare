Class {
	#name : 'Acceleration',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Acceleration >> applyPermanentEffectOn: aShip overThrow: aThrow [

	^ aThrow + 1
]
