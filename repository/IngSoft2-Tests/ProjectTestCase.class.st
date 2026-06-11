Class {
	#name : 'ProjectTestCase',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ProjectTestCase >> positionOf: spaceshipNames in: game [

	^ spaceshipNames collect: [ :name |
			  {
				  name.
				  ((game spaceshipNamed: name) at:#position)} ]
]

{ #category : 'asserting' }
ProjectTestCase >> positionOf: spaceshipNames in: game afterTurns: numberOfTurns [

	^ (1 to: numberOfTurns) collect: [ :turn |
			  game throwDiceNextTurn.
			  self positionOf: spaceshipNames in: game ]
]

{ #category : 'asserting' }
ProjectTestCase >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage ]
]
