Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#instVars : [
		'cardToCancel',
		'shipThatReceivesEffect',
		'cardManager',
		'listOfShips',
		'board',
		'ships'
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
InstantCard >> withCardToCancel: _cardToCancel [

	cardToCancel := _cardToCancel.
	^self
]

{ #category : 'initialization' }
InstantCard >> withShips: _listOfShips [

	ships := _listOfShips.

	^ self
]

{ #category : 'initialization' }
InstantCard >> withTargetShipName: _target [

	shipThatReceivesEffect := _target .

	^ self
]
