Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Repeat >> applyInstantEffect [

	board applyLastEffectTo: shipThatReceivesEffect in: listOfShips
]

{ #category : 'initialization' }
Repeat >> initialize [

	super initialize.
	shipThatReceivesEffect := ''.
	listOfShips := {  }.
	board := BoardBuilder new build.
	^ self
]
