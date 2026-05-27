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
HyperJump >> applyEffectTo: aShip in: aBoard [

	| currentJump |
	(aShip positionInBoard: aBoard) = number ifTrue: [
			currentJump := ((jumps at: jumpIndex) / parsecs) floor.
			jumpIndex := jumpIndex % jumps size + 1.
			^ aShip movesForward: currentJump ].
	^ aShip
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

{ #category : 'accessing' }
HyperJump >> withJumps: listOfJumps [

	jumps := listOfJumps sorted: [ :a :b | a > b ].
	jumpIndex := 1.

	^ self
]
