Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
InstantCard >> = aCard [

	^ self class = aCard class
]

{ #category : 'comparing' }
InstantCard >> isInstantCard [

^true
]
