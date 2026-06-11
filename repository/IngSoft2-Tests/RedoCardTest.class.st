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
				#( 'Ship2' 5 ) }
]

{ #category : 'tests' }
RedoCardTest >> test014aRedoCardWorksWithOverload [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	"Ship1 recibe Overload y Speed. Ship2 recibe Redo y Overload"
	deckMock := DeckMock withSequence: {
			            Overload new.
			            Speed new.
			            Redo new.
			            Overload new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withDeck: deckMock;
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        build.

	game throwDicePermanentCardNextTurn:
		(Overload new affectsShipWithName: 'Ship2'). "lands on 5 and casts overload on ship2"

	game
		instantCard: (Redo new affectsShipWithName: 'Ship1')"casts redo on ship1 (overload)"
		from: 'Ship2'.

	game throwDiceNextTurn. "ship 2 affected by overload lands on 3"
	game throwDiceNextTurn. "ship 1 affected by overload lands on 7"

	self
		assert: ((game spaceshipNamed: 'Ship1') at: 'position')
		equals: 7. 
	self
		assert: ((game spaceshipNamed: 'Ship2') at: 'position')
		equals: 3
]
