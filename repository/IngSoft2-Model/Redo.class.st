Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#instVars : [
		'shipThatReceivesEffect',
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Redo >> affectsShipWithName: _target [

	shipThatReceivesEffect := _target.
	^ self
]

{ #category : 'behavior' }
Redo >> applyInstantEffectOnGame: aGame [

	aGame
		repeatCardEffectForShipNamed: shipThatReceivesEffect
		orCardToCancel: cardToCancel
]

{ #category : 'behavior' }
Redo >> redoCardWithShipThatReceivesEffect: _shipThatReceivesEffect orCardToCancel: _cardToCancel andGame: aGame [

	"aGame
		repeatCardEffectForShipNamed: _shipThatReceivesEffect
		orCardToCancel: _cardToCancel"
		
	"self error: 'Redo card can not be repeated'"
	
	"NO TIENE RAZON DE EXISTIR PQ NUNCA DEBERIA SER LLAMADA, SI NO SE GUARDA UNA CARTA CUANDO ES REDO"
]

{ #category : 'initialization' }
Redo >> withCardToCancel: aCard [

	cardToCancel := aCard.
	^ self
]
