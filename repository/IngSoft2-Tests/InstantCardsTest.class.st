Class {
	#name : 'InstantCardsTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
InstantCardsTest >> test009EffectOfcancellationCardOnCertainShip [

	| ships dicePool activeCards resultInShip1 |
	dicePool := DicePool withDice: {
			            (DiceMock withSides: 4 andSequence: #( 4 )).
			            (DiceMock withSides: 4 andSequence: #( 4 )) }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }.

	activeCards := CardManager withActiveCards: {
			               Acceleration new.
			               (Speed new affectsShipWithName: 'one').
			               (Overload new affectsShipWithName: 'two') }.

	activeCards cancel: Acceleration new.

	resultInShip1 := activeCards
		                 applyPermanentEffectOnShip: ships first
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 9. "Acceleration was cancelled"
	
	self assert: activeCards permanentCards equals: {
			(Speed new affectsShipWithName: 'one').
			(Overload new affectsShipWithName: 'two') } asOrderedCollection 
]

{ #category : 'tests' }
InstantCardsTest >> test010cantCancelifNothingToCancel [

	| activeCards |
	activeCards := CardManager withActiveCards: {  }.

	self
		should: [ activeCards cancel: Acceleration new ]
		raiseErrorWithMessageText:
		'Impossible to cancel a card that is not active'
]

{ #category : 'tests' }
InstantCardsTest >> test011OnePlayerUsesSpeedCardAndOtherUsesCancellationCardAfter [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	deckMock := DeckMock withSequence: {
			            Overload new.
			            Cancellation new.
			            Repeat new.
			            Speed new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 2 2 2 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        withDeck: deckMock;
		        withBoardBuilder: (MockBoardBuilder new withEffects: {
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new });
		        build.

	game throwDiceNextTurn.
	game throwDicePermanentCardNextTurn:
		(Speed new affectsShipWithName: 'Ship2').

	game
		instantCard: (Cancellation new withCardToCancel: Speed new)
		from: 'Ship1'.

	game throwDiceNextTurn.
	game throwDiceNextTurn.


	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 7 ).
				#( 'Ship2' 6 ) }
]

{ #category : 'tests' }
InstantCardsTest >> test012Ship1LandsOnSpeedupThenShip2UsesRepeatCardOnItself [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	deckMock := DeckMock withSequence: {
			            Overload new.
			            Cancellation new.
			            Repeat new.
			            Speed new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 2 3 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        withDeck: deckMock;
		        withBoardBuilder: (MockBoardBuilder new withEffects: {
						         Square new.
						         Square new.
						         Speedup new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new.
						         Square new });
		        build.

	game throwDiceNextTurn.
	game throwDiceNextTurn.

	game
		instantCard: (Repeat new affectsShipWithName: 'Ship2')
		from: 'Ship2'.



	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 7 ).
				#( 'Ship2' 8 ) }
]

{ #category : 'tests' }
InstantCardsTest >> test013redoCardWorksWithSpeed [

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

{ #category : 'tests' }
InstantCardsTest >> test014playerUsesRepeatCard [

	| boardBuilder dice game deckMock |
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                Speedup new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	deckMock := DeckMock withSequence: {
			            Speed new.
			            Speed new.
			            Repeat new.
			            Speed new }.

	dice := DicePool withDice:
		        { (DiceMock withSides: 4 andSequence: #( 1 3 )) }.

	game := GameBuilder new
		        withDicepool: dice;
		        withBoardBuilder: boardBuilder;
		        withDeck: deckMock;
		        build.

	game throwDiceNextTurn.
	game throwDiceNextTurn.
	game instantCard: (Repeat new affectsShipWithName: 'two') from: 'two'
]
