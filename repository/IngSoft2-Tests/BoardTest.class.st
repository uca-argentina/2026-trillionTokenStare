Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001whenTheBoardIsCreatedThenTheBoardExists [
	| board |
	board := Board new.
	self assert: (board isMemberOf: Board).

	
]

{ #category : 'tests' }
BoardTest >> test002ifTheBoardHasLessThanOneSquareThenTheBoardIsNotValid [
	self 
	  should: [ Board withSquares: 0 ] 
	  raise: Error   
	  withExceptionDo: [ :error |
		 self 
		   assert: error messageText
		   equals: 'The board must have at least 1 square.' ]
	.
	
]
