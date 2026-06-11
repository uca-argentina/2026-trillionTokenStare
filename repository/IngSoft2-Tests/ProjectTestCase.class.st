Class {
	#name : 'ProjectTestCase',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ProjectTestCase >> assertDictionary: dictionary contains: expected [

	| complies |
	complies := expected associations allSatisfy: [ :asociation |
			            | key value |
			            key := asociation key.
			            value := asociation value.

			            (dictionary at: key ifAbsent: [ nil ]) = value ].

	self assert: complies
]

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

{ #category : 'asserting' }
ProjectTestCase >> statusOf: spaceshipNames afterTurns: numberOfTurns in: game [ 

	^ (1 to: numberOfTurns) collect: [ :turn |
			  game throwDiceNextTurn.
			  self statusOf: spaceshipNames in: game ]
]

{ #category : 'asserting' }
ProjectTestCase >> statusOf: spaceshipNames in: game [

	^ spaceshipNames collect: [ :name | game spaceshipNamed: name ]
]
