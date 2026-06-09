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
   self validateSequence: aSequence.
	sequence := aSequence.
	index := 1
]

{ #category : 'validation' }
DeckMock >> validateSequence: aSequence [.
	(aSequence isMemberOf: Array) ifFalse: [
		self error: 'The mocksequence must be an array' ].
	aSequence isNotEmpty ifFalse: [
		self error: 'The mocksequence must have any card' ].
	(aSequence allSatisfy: [ :queue | queue isKindOf: Card ]) ifFalse: [
		self error: 'The mocksequence must have card exclusively' ].
	
]
