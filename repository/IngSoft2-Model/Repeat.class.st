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

{ #category : 'initialization' }
Repeat >> applyInstantEffectOnGame: aGame [

	aGame ships
		shipNamed: shipThatReceivesEffect
		repeatsEffectinside: aGame board
	"board repeatLastEffectOn: shipThatReceivesEffect fromShips: shipManager"
]

{ #category : 'initialization' }
Repeat >> initialize [

	super initialize.
	^ self
]
