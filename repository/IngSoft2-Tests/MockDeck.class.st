Class {
	#name : 'MockDeck',
	#superclass : 'Object',
	#instVars : [
		'sequence',
		'index'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
MockDeck class >> withSequence: aSequence [
	^ self new initializeWithSequence: aSequence .
]

{ #category : 'behaviour' }
MockDeck >> drawCard [
   
   | current_index |
   current_index := index.
	index := index % sequence size + 1.
	^ sequence at: current_index 
]

{ #category : 'initialization' }
MockDeck >> initializeWithSequence: aSequence [ 
	sequence := aSequence .
	index := 1
]
