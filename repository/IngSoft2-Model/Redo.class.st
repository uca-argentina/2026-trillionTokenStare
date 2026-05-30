Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#instVars : [
		'lastCardPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Redo >> affectsShipWithName: _target [

	shipThatReceivesEffect := _target .

	^ self
]

{ #category : 'behavior' }
Redo >> applyInstantEffect [

	lastCardPlayed isPermanentCard ifTrue: [
			cardManager
				addPermanentCard:
				(lastCardPlayed affectsShipWithName: shipThatReceivesEffect)
				from: shipManager shipInTurn ].

	lastCardPlayed isInstantCard ifTrue: [
			lastCardPlayed
				withBoard: board;
				withCardManager: cardManager;
				withSpaceships: shipManager;
				affectsShipWithName: shipThatReceivesEffect;
				withCardToCancel: cardToCancel;
				applyInstantEffect ]
]

{ #category : 'initialization' }
Redo >> cancelCard: aCard [

	cardToCancel := aCard.
	^ self
]

{ #category : 'initialization' }
Redo >> initialize [

	super initialize.
	^ self
]

{ #category : 'comparing' }
Redo >> isRedo [

^true
]

{ #category : 'initialization' }
Redo >> withLastCardPlayed: aCard [

	lastCardPlayed := aCard.

	^ self
]
