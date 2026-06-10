Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#instVars : [
		'lastCardPlayed',
		'shipThatReceivesEffect',
		'cardToCancel'
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
Redo >> applyInstantEffectOnGame: aGame [

	aGame lastCardPlayed isPermanentCard ifTrue: [
			aGame cards
				addPermanentCard:
				(aGame lastCardPlayed affectsShipWithName: shipThatReceivesEffect)
				from: aGame ships shipInTurn ].

	aGame lastCardPlayed isInstantCard ifTrue: [
			aGame cards
				affectsShipWithName: shipThatReceivesEffect;
				cancelCard: cardToCancel;
				applyInstantEffectOnGame: aGame ]
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
Redo >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]

{ #category : 'initialization' }
Redo >> withLastCardPlayed: aCard [

	lastCardPlayed := aCard.

	^ self
]
