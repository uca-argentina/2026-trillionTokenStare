Class {
	#name : 'DiceTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> test001whenDiceIsCreatedWithLessThan4SidesThenIsNotValid [

	self
		should: [ Dice withSides: 3 ]
		raiseErrorWithMessageText: 'The dice must have at least 4 sides'
]

{ #category : 'tests' }
DiceTest >> test002WhenPreloadedDiceThrowsSequenceAndItLoopsThenIsValid [

	| dice diceThrows |
	dice := DiceMock withSides: 6 andSequence: #( 1 3 5 6 ).
	
	diceThrows := (1 to: 5) collect: [ :i | dice throw ].

	self assert: diceThrows equals: #( 1 3 5 6 1 )
]

{ #category : 'tests' }
DiceTest >> test003WhenPreloadedDiceThrowsValueAboveNumberOfSidesThenNotValid [

	| dice |
	dice := DiceMock withSides: 6 andSequence: #( 7 ).


	self
		should: [ dice throw ]
		raiseErrorWithMessageText:
		'Dice must throw a value less or equal number of sides'
]

{ #category : 'tests' }
DiceTest >> test004WhenPreloadedDiceThrowsValueLessThanOneThenNotValid [

	| dice |
	dice := DiceMock withSides: 6 andSequence: #( 0 ).

	self
		should: [ dice throw ]
		raiseErrorWithMessageText: 'Dice must throw a value of at least 1'
]

{ #category : 'tests' }
DiceTest >> test005WhenADicePoolIsCreatedWithoutItBeingAnArrayOfDiceThenIsNotValid [

	| dice1  |
	dice1 := DiceMock withSides: 6 andSequence: #( 1 3 2 5 ).
 
	self should: [ DicePool withDice: dice1 ] raiseErrorWithMessageText: 'Dice pool initializes with a collection of dice'
		
]

{ #category : 'tests' }
DiceTest >> test006WhenThrowingAPoolOfDiceTheResultOfEachDiceIsAddedAccordingly [

	| dice1 dice2 dicePool diceThrows |
	dice1 := DiceMock withSides: 6 andSequence: #( 1 3 2 5 ).
	dice2 := DiceMock withSides: 4 andSequence: #( 4 2 1 2 ).
	dicePool := DicePool withDice: {dice1 . dice2}. 

	diceThrows := (1 to: 5) collect: [ :i | dicePool throw ].

	self assert: diceThrows equals: #( 5 5 3 7 5 )
		
]
