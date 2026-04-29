Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> test001whenDiceIsCreatedWithLessThan4SidesThenIsNotValid [
	
	self 
	  should: [ Dice withSides: 3 ] 
	  raise: Error   
	  withExceptionDo: [ :error |
		 self 
		   assert: error messageText
		   equals: 'The dice must have at least 4 sides' ]
]
