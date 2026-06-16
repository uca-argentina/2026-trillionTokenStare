Class {
	#name : 'HyperJump',
	#superclass : 'Square',
	#instVars : [
		'jumps',
		'jumpIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
HyperJump >> applyEffectToShip: certainShip inGame: aGame [

	| currentJump |
	currentJump := ((jumps at: jumpIndex) / parsecs) floor.
	jumpIndex := jumpIndex % jumps size + 1.

	
	aGame moveShip: certainShip forward: currentJump 

]

{ #category : 'accessing' }
HyperJump >> initialize [

	super initialize.
	position := 1.
	parsecs := 1.
	jumps := { 300. 200 }.
	jumpIndex := 1.

	^ self
]

{ #category : 'behavior' }
HyperJump >> setLastEffectIn: aBoard [

	aBoard lastEffect: self
]

{ #category : 'accessing' }
HyperJump >> validateListOfJumps: listOfJumps [

	(listOfJumps anySatisfy: [ :jump | jump <= 0 ]) ifTrue: [
		self error: 'HyperJump distances must be greater than 0' ]
]

{ #category : 'accessing' }
HyperJump >> withJumpsInLightYears: listOfJumps [

	jumps := (listOfJumps sorted: [ :a :b | a > b ]) collect: [ :jump | jump * 3 ].
	jumpIndex := 1.

	^ self
]

{ #category : 'accessing' }
HyperJump >> withJumpsInParsecs: listOfJumps [

	self validateListOfJumps: listOfJumps.
	jumps := listOfJumps sorted: [ :a :b | a > b ].
	jumpIndex := 1.

	^ self
]
