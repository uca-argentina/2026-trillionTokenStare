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

{ #category : 'as yet unclassified' }
HyperJump >> applyEffectToShip: certainShip inGame: aGame [

	| currentJump |
	currentJump := ((jumps at: jumpIndex) / parsecs) floor.
	jumpIndex := jumpIndex % jumps size + 1.

	aGame ships moveShip: certainShip forward: currentJump

	"| currentJump |
	aCondition ifTrue: [
			currentJump := ((jumps at: jumpIndex) / parsecs) floor.
			jumpIndex := jumpIndex % jumps size + 1.
			^ aShip movesForward: currentJump ].
	^ aShip"
]

{ #category : 'accessing' }
HyperJump >> initialize [

	super initialize.
	number := 1.
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
HyperJump >> withJumpsInLightYears: listOfJumps [

	jumps := (listOfJumps sorted: [ :a :b | a > b ]) collect: [ :jump | jump * 3 ].
	jumpIndex := 1.

	^ self
]

{ #category : 'accessing' }
HyperJump >> withJumpsInParsecs: listOfJumps [

	jumps := listOfJumps sorted: [ :a :b | a > b ].
	jumpIndex := 1.

	^ self
]
