Class {
	#name : 'HyperJump',
	#superclass : 'Square',
	#instVars : [
		'jumps',
		'jumpIndex',
		'parsecsToSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperJump class >> defaultAt: squareNumber andJumps: listOfSquaresToJump andParsecsToSquares: parsecsToSquares [

	^ self new initializeAt: squareNumber withJumps: listOfSquaresToJump andParsecsToSquares: parsecsToSquares 
]

{ #category : 'as yet unclassified' }
HyperJump >> applyEffectTo: aShip [

	| currentJump |
	^ aShip position = number
		  ifTrue: [
			  currentJump := (parsecsToSquares * (jumps at: jumpIndex)) floor.
			  jumpIndex := jumpIndex % jumps size + 1.
			  ^ aShip movesForward: currentJump ]
		  ifFalse: [ ^ aShip ]
]

{ #category : 'accessing' }
HyperJump >> initializeAt: squareNumber withJumps: listOfJumps andParsecsToSquares: _parsecsToSquares [ 

	number := squareNumber.
	parsecsToSquares := _parsecsToSquares.
	jumps := listOfJumps.
	jumpIndex := 1
]
