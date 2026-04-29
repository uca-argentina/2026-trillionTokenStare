Class {
	#name : 'DiceMockTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceMockTest >> test001whenDiceIsCreatedWithLessThan4SidesThenIsNotValid [

	self
		should: [ DiceMock withSides: 3 ]
		raiseErrorWithMessageText: 'The dice must have at least 4 sides'
]

{ #category : 'tests' }
DiceMockTest >> test002WhenPreloadedDiceThrowsSequenceAndItLoopsThenIsValid [

	| dice diceThrows |
	dice := DiceMock withSides: 6 andSequence: #( 1 3 5 6 ).
	
	diceThrows := (1 to: 5) collect: [ :i | dice throw ].

	self assert: diceThrows equals: #( 1 3 5 6 1 )
]

{ #category : 'tests' }
DiceMockTest >> test003WhenPreloadedDiceThrowsValueAboveNumberOfSidesThenNotValid [

	| dice |
	dice := DiceMock withSides: 6 andSequence: #( 7 ).


	self
		should: [ dice throw ]
		raiseErrorWithMessageText:
		'Dice must throw a value less or equal number of sides'
]

{ #category : 'tests' }
DiceMockTest >> test004WhenPreloadedDiceThrowsValueLessThanOneThenNotValid [

	| dice |
	dice := DiceMock withSides: 6 andSequence: #( 0 ).

	self
		should: [ dice throw ]
		raiseErrorWithMessageText: 'Dice must throw a value of at least 1'
]
