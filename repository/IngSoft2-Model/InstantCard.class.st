Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#instVars : [
		'cardToCancel',
		'shipThatReceivesEffect',
		'cardManager',
		'board',
		'shipManager',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
InstantCard >> = aCard [

	^ self class = aCard class
]

{ #category : 'initialization' }
InstantCard >> affectsShipWithName: _target [

	^ self
]

{ #category : 'initialization' }
InstantCard >> cancelCard: aCard [

	^ self
]

{ #category : 'comparing' }
InstantCard >> isInstantCard [

^true
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
InstantCard >> withGame: _game [

	game := _game.

	^ self
]

{ #category : 'initialization' }
InstantCard >> withLastCardPlayed: aCard [

	^ self
]

{ #category : 'initialization' }
InstantCard >> withSpaceships: _listOfShips [

	shipManager := _listOfShips.

	^ self
]
