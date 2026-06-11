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

{ #category : 'tests' }
RedoCardTest >> test015RedoCardWorksWithAcceleration [
    | ships dicePool game deckMock |
    ships := {
                 (Spaceship withName: 'Ship1').
                 (Spaceship withName: 'Ship2') }.

    deckMock := DeckMock withSequence: {
                        Acceleration new.
                        Speed new.
                        Redo new.
                        Acceleration new }.

    dicePool := DicePool withDice:
                    { (DiceMock withSides: 4 andSequence: #( 4 )) }.

    game := GameBuilder new
                withDeck: deckMock;
                withSpaceships: ships;
                withDicepool: dicePool;
                build.

    game throwDicePermanentCardNextTurn: Acceleration new. "turn of Ship1: 1 + 4 (dice) + 2 (Acceleration) = 7"

    game instantCard: (Redo new) from: 'Ship2'."ship2 casts redo (Acceleration) on itself"

    game throwDiceNextTurn. "turn of Ship2: 1 + 4 (dice) + 2 (Acceleration) = 7"
    game throwDiceNextTurn. "turn of Ship1: 6 + 4 (dice) + 2 (Acceleration) = 12"

    self assert: ((game spaceshipNamed: 'Ship1') at: 'position') equals: 2." second lap in a board length 10 (absolute position 12)"
    self assert: ((game spaceshipNamed: 'Ship2') at: 'position') equals: 7." still on first lap"
]

{ #category : 'tests' }
RedoCardTest >> test016RedoCardWorksWithCancellation [

	| ships dicePool game deckMock speedCard accelerationCard |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	deckMock := DeckMock withSequence: {
			            Speed new.
			            Redo new.
			            Cancellation new.
			            Acceleration new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withDeck: deckMock;
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        build.

	"cards to play"
	speedCard := Speed new affectsShipWithName: 'Ship1'.
	accelerationCard := Acceleration new.

	game throwDicePermanentCardNextTurn: speedCard.
	game throwDicePermanentCardNextTurn: accelerationCard.

	"Ship2 uses Cancelación on Speed card"
	game
		instantCard: (Cancellation new withCardToCancel: speedCard)
		from: 'Ship2'.

	"Ship1 uses Redo copying Cancellation, aims to delete Acceleration"
	game
		instantCard: (Redo new withCardToCancel: accelerationCard)
		from: 'Ship1'.

	self assert: game activeCards isEmpty
]

{ #category : 'tests' }
RedoCardTest >> test017RedoCardCopiesRepeatWhichCopiesSquareEffect [

	| boardBuilder ships dicePool game deckMock |
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new. "1"
			                Speedup new. "2"
			                Square new. "3"
			                Square new. "4"
			                Square new. "5"
			                Square new. "6"
			                Square new. "7"
			                Square new. "8"
			                Square new. "9"
			                Square new "10" }.

	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	deckMock := DeckMock withSequence: {
			            Redo new.
			            Speed new.
			            Repeat new.
			            Speed new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 1 )) }.

	game := GameBuilder new
		        withDeck: deckMock;
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool: dicePool;
		        build.


	game throwDiceNextTurn. "ship1 lands on speed up... 2+4 = 6"

	game
		instantCard: (Repeat new affectsShipWithName: 'Ship2')
		from: 'Ship2'. "ship2 uses repeat on itself, repeats speedup... 1+4 = 5"

	game
		instantCard: (Redo new affectsShipWithName: 'Ship1')
		from: 'Ship1'. " ship1 casts redo on itself, drawing repeat which repeats speedup... 6+4 = 10"

	self
		assert: ((game spaceshipNamed: 'Ship1') at: 'position')
		equals: 10.
	self
		assert: ((game spaceshipNamed: 'Ship2') at: 'position')
		equals: 5
]
