Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#instVars : [
		'shipThatReceivesEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Repeat >> affectsShipWithName: _target [

	shipThatReceivesEffect := _target.
	^ self
]

{ #category : 'behavior' }
Repeat >> applyInstantEffectOnGame: aGame [

	aGame setLastPlayedCard: self.
	aGame repeatSquareEffectForShipNamed: shipThatReceivesEffect
	"aGame ships
		shipNamed: shipThatReceivesEffect
		repeatsEffectinsGame: aGame"
]

{ #category : 'initialization' }
Repeat >> initialize [

	super initialize.
	^ self
]
