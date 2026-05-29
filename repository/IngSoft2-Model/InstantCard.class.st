Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#instVars : [
		'cardToCancel',
		'shipThatReceivesEffect',
		'cardManager',
		'board',
		'shipManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
InstantCard >> = aCard [

	^ self class = aCard class
]

{ #category : 'initialization' }
InstantCard >> withBoard: _board [

	board := _board.

	^ self
]

{ #category : 'initialization' }
InstantCard >> withCardManager: _cardManager [

	cardManager := _cardManager.
	^self
]

{ #category : 'initialization' }
InstantCard >> withSpaceships: _listOfShips [

	shipManager := _listOfShips.

	^ self
]
