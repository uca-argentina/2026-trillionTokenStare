Class {
	#name : 'DeckMock',
	#superclass : 'Deck',
	#instVars : [
		'sequence',
		'index'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
DeckMock class >> withSequence: aSequence [
	^ self new initializeWithSequence: aSequence .
]

{ #category : 'behaviour' }
DeckMock >> drawCard [
   
   | current_index |
   current_index := index.
	index := index % sequence size + 1.
	^ sequence at: current_index 
]

{ #category : 'initialization' }
DeckMock >> initializeWithSequence: aSequence [ 
	sequence := aSequence.
	index := 1
]
