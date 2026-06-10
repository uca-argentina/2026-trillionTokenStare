Class {
	#name : 'CardsTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardsTest >> test001OverloadCard [

	| card ships dicePool resultInShip1 resultInShip2 |
	dicePool := DicePool withDice: {
			            (DiceMock withSides: 4 andSequence: #( 4 )).
			            (DiceMock withSides: 4 andSequence: #( 4 )) }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }.

	card := Overload new affectsShipWithName: 'two'.

	resultInShip1 := card
		                 applyPermanentEffectOnShip: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyPermanentEffectOnShip: ships last
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 8.
	self assert: resultInShip2 equals: 6
]

{ #category : 'tests' }
CardsTest >> test002SpeedCard [

	| card ships dicePool resultInShip1 resultInShip2 |
	dicePool := DicePool withDice: {
			            (DiceMock withSides: 4 andSequence: #( 4 )).
			            (DiceMock withSides: 4 andSequence: #( 4 )) }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }.

	card := Speed new affectsShipWithName: 'two'.

	resultInShip1 := card
		                 applyPermanentEffectOnShip: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyPermanentEffectOnShip: ships last
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 8.
	self assert: resultInShip2 equals: 9
]

{ #category : 'tests' }
CardsTest >> test003AccelerationCard [

	| card ships dicePool resultInShip1 resultInShip2 |
	dicePool := DicePool withDice: {
			            (DiceMock withSides: 4 andSequence: #( 4 )).
			            (DiceMock withSides: 4 andSequence: #( 4 )) }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }.

	card := Acceleration new.

	resultInShip1 := card
		                 applyPermanentEffectOnShip: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyPermanentEffectOnShip: ships last
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 9.
	self assert: resultInShip2 equals: 9
]

{ #category : 'tests' }
CardsTest >> test004ActiveCards [

	| ships dicePool resultInShip1 resultInShip2 activeCards |
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

	resultInShip1 := activeCards
		                 applyPermanentEffectOnShip: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := activeCards
		                 applyPermanentEffectOnShip: ships last
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 10.
	self assert: resultInShip2 equals: 7
]

{ #category : 'tests' }
CardsTest >> test005PlayerInputsCardThatDoesNotPosess [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.
	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.
	deckMock := DeckMock withSequence: { Acceleration new }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        withDeck: deckMock;
		        build.



	self
		should: [
				game throwDicePermanentCardNextTurn:
					(Overload new affectsShipWithName: 'Ship2') ]
		raiseErrorWithMessageText:
		'Ship can not play a card that doesnt posess'
]

{ #category : 'tests' }
CardsTest >> test006PlayerPlaysAccelerationCardAndItAffectsAllPlayers [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.
	deckMock := DeckMock withSequence: { Acceleration new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        withDeck: deckMock;
		        build.

	game throwDicePermanentCardNextTurn: Acceleration new.
	game throwDiceNextTurn.

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 6 ).
				#( 'Ship2' 6 ) }
]

{ #category : 'tests' }
CardsTest >> test007PlayerPlaysSpeedCardAndItAffectsItSelf [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.
	deckMock := DeckMock withSequence: { Speed new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        withSquares: 20;
		        withDeck: deckMock;
		        build.

	game throwDicePermanentCardNextTurn:
		(Speed new affectsShipWithName: 'Ship1').
	game throwDiceNextTurn.
	game throwDiceNextTurn.

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 11 ).
				#( 'Ship2' 5 ) }
]

{ #category : 'tests' }
CardsTest >> test008PlayerPlaysOverloadCardAndItAffectsTheOtherPlayer [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.
	deckMock := DeckMock withSequence: { Overload new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        withDeck: deckMock;
		        build.

	game throwDicePermanentCardNextTurn:
		(Overload new affectsShipWithName: 'Ship2').
	game throwDiceNextTurn.
	game throwDiceNextTurn.

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 9 ).
				#( 'Ship2' 3 ) }
]

{ #category : 'tests' }
CardsTest >> test009cancellationCard [

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

	self assert: resultInShip1 equals: 9"Acceleration was cancelled"
]

{ #category : 'tests' }
CardsTest >> test010repeatCard [

	| ships board finalPositions |
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }.

	board := MockBoardBuilder new
		         withEffects: {
				         Square new.
				         Speedup new.
				         Square new.
				         Square new.
				         Square new.
				         Square new.
				         Square new.
				         Square new.
				         Square new };
		         build.

	"
	game next turn loop across objects
	"
	ships at: 1 put: (ships first movesForward: 1).

	(board shipInsideBoard: ships first) ifTrue: [
		ships := board applyEffectsOf: ships first to: ships ].
	"
	action to be tested
	"
	ships := board repeatLastEffectOn: ships second fromShips: ships.

	finalPositions := {
		                  (Spaceship withName: 'one' andPosition: 6).
		                  (Spaceship withName: 'two' andPosition: 5) }.

	self assert: ships equals: finalPositions
]

{ #category : 'tests' }
CardsTest >> test011OnePlayerUsesSpeedCardAndOtherUsesCancellationCardAfter [

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
CardsTest >> test012Ship1LandsOnSpeedupThenShip2UsesRepeatCardOnItself [

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
CardsTest >> test013redoCardWorksWithSpeed [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	deckMock := DeckMock withSequence: {
			            Speed new.
			            Card new.
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
