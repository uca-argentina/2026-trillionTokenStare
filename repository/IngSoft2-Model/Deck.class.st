Class {
	#name : 'Deck',
	#superclass : 'Object',
	#instVars : [
		'cardsCollection'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behaviour' }
Deck >> drawCard [
   ^ cardsCollection atRandom .
]

{ #category : 'initialization' }
Deck >> initialize [ 
   super initialize.
	cardsCollection := { Cancellation new . Redo new . Repeat new . Acceleration new . Overload new . Speed new } asOrderedCollection.
]
