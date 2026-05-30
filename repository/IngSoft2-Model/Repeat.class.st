Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Repeat >> affectsShipWithName: _target [

	shipThatReceivesEffect := _target .

	^ self
]

{ #category : 'initialization' }
Repeat >> applyInstantEffect [

	shipManager
		shipNamed: shipThatReceivesEffect
		repeatsEffectinside: board
	"board repeatLastEffectOn: shipThatReceivesEffect fromShips: shipManager"
]

{ #category : 'initialization' }
Repeat >> initialize [

	super initialize.
	shipThatReceivesEffect := Spaceship withName: ''.
	shipManager := SpaceshipManager withSpaceships: {  }.
	board := BoardBuilder new build.
	^ self
]
