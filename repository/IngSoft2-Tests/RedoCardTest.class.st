Class {
	#name : 'RedoCardTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> test013redoCardWorksWithSpeed [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	deckMock := DeckMock withSequence: {
			            Speed new.
			            Acceleration new.
			            Redo new.
			            Speed new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 2 3 )) }.

	game := GameBuilder new
		        withDeck: deckMock;
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        build.

	game throwDicePermanentCardNextTurn:
		(Speed new affectsShipWithName: 'Ship1').
	game
		instantCard: (Redo new affectsShipWithName: 'Ship2')
		from: 'Ship2'.
	game throwDiceNextTurn.

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 4 ).
				#( 'Ship2' 6 ) }
]
