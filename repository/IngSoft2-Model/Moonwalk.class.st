Class {
	#name : 'Moonwalk',
	#superclass : 'Square',
	#instVars : [
		'backtrack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Moonwalk class >> default [

	^ self new initializeWithBacktrack: 3
]

{ #category : 'initialization' }
Moonwalk >> initializeWithBacktrack: anAmountToBacktrack [

	backtrack := anAmountToBacktrack
]
