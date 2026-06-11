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
InstantCardsTest >> test014playerUsesRepeatCardAndRepeatsSpeedupSquare [

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
	game instantCard: (Repeat new affectsShipWithName: 'two') from: 'two'."two uses repeat on itself"

	self assert: ((game spaceshipNamed: 'one') at: 'position') equals: 6.
	self assert: ((game spaceshipNamed: 'two') at: 'position') equals: 8
]

{ #category : 'tests' }
InstantCardsTest >> test015playerUsesRepeatCardAndRepeatsWormholeSquare [

	| boardBuilder dice game deckMock |
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new. "1"
			                Square new. "2"
			                Square new. "3"
			                Square new. "4"
			                Square new. "5"
			                Wormhole new. "6"
			                Square new. "7"
			                Square new. "8"
			                Square new. "9"
			                Square new "10" }.

	deckMock := DeckMock withSequence: {
			            Speed new.
			            Repeat new.
			            Repeat new.
			            Speed new }.

	dice := DicePool withDice:
		        { (DiceMock withSides: 6 andSequence: #( 5 6 )) }.

	game := GameBuilder new
		        withDicepool: dice;
		        withBoardBuilder: boardBuilder;
		        withDeck: deckMock;
		        build.

	game throwDiceNextTurn."one falls on wormhole, goes back to 2"
	game throwDiceNextTurn."two falls on 7"

	game instantCard: (Repeat new affectsShipWithName: 'two') from: 'one'."one uses repeat on two, one goes back to 2"

	self assert: ((game spaceshipNamed: 'one') at: 'position') equals: 2.
	self assert: ((game spaceshipNamed: 'two') at: 'position') equals: 3
]

{ #category : 'tests' }
InstantCardsTest >> test016playerUsesRepeatCardAndRepeatsMoonwalkSquare [
    | boardBuilder dice game deckMock |
    boardBuilder := MockBoardBuilder new withEffects: {
                            Square new. "1"
                            Square new. "2"
                            Square new. "3"
                            Square new. "4"
                            Square new. "5"
                            Moonwalk new. "6"
                            Square new. "7"
                            Square new. "8"
                            Square new. "9"
                            Square new. "10" }.

    deckMock := DeckMock withSequence: {
                        Speed new.
                        Repeat new.
                        Repeat new.
                        Speed new }.

    dice := DicePool withDice: { (DiceMock withSides: 6 andSequence: #( 3 5 )) }.

    game := GameBuilder new
                withDicepool: dice;
                withBoardBuilder: boardBuilder;
                withDeck: deckMock;
                build.

    game throwDiceNextTurn.
    game throwDiceNextTurn.
    
    game instantCard: (Repeat new affectsShipWithName: 'one') from: 'one'.

    self assert: ((game spaceshipNamed: 'one') at:'position') equals: 1.
    self assert: ((game spaceshipNamed: 'two') at:'position') equals: 3.
]

{ #category : 'tests' }
InstantCardsTest >> test017playerUsesRepeatCardAndRepeatsAtomicBombSquare [

	| boardBuilder dice game deckMock |
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new. "1"
			                Square new. "2"
			                Square new. "3"
			                AtomicBomb new. "4"
			                Square new "5" }.

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
	game throwDiceNextTurn. "lands on Atomic bomb"
	self assert: ((game spaceshipNamed: 'one') at: 'position') equals: 1.
	self assert: ((game spaceshipNamed: 'two') at: 'position') equals: 1.

	game throwDiceNextTurn.
	self assert: ((game spaceshipNamed: 'one') at: 'position') equals: 2.
	self assert: ((game spaceshipNamed: 'two') at: 'position') equals: 1.

	game instantCard: (Repeat new affectsShipWithName: 'two') from: 'two'. "Repeats Atomic Bomb"
	self assert: ((game spaceshipNamed: 'one') at: 'position') equals: 1.
	self assert: ((game spaceshipNamed: 'two') at: 'position') equals: 1
]

{ #category : 'tests' }
InstantCardsTest >> test018playerUsesRepeatCardAndRepeatsHyperJumpSquare [
    | boardBuilder dice game deckMock |
    boardBuilder := MockBoardBuilder new withEffects: {
                            Square new. "1"
                            HyperJump new. "2" "Using default list {300. 200}"
                            Square new. "3"
                            Square new. "4"
                            Square new. "5"
                            Square new. "6"
                            Square new. "7"
                            Square new. "8"
                            Square new. "9"
                            Square new. "10" }. "Parsecs per square = 1000 / 10 = 100"

    deckMock := DeckMock withSequence: {
                        Speed new.
                        Speed new.
                        Repeat new.
                        Speed new }.

    dice := DicePool withDice: { (DiceMock withSides: 4 andSequence: #( 1 )) }.

    game := GameBuilder new
                withDicepool: dice;
                withBoardBuilder: boardBuilder;
                withDeck: deckMock;
                build.

    game throwDiceNextTurn."lands on hyper jump: 2 + 3 = 5"
    game throwDiceNextTurn."lands on hyper jump: 2 + 2 = 4"
    
    game instantCard: (Repeat new affectsShipWithName: 'two') from: 'two'.

    self assert: ((game spaceshipNamed: 'two') at:'position') equals: 7. "repeats hyper jump: 4 + 3"
]

{ #category : 'tests' }
InstantCardsTest >> test019playerUsesRepeatCardOnNormalSquareHasNoEffect [
    | boardBuilder dice game deckMock |
    boardBuilder := MockBoardBuilder new withEffects: {
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

    dice := DicePool withDice: { (DiceMock withSides: 4 andSequence: #( 1 1 )) }.

    game := GameBuilder new
                withDicepool: dice;
                withBoardBuilder: boardBuilder;
                withDeck: deckMock;
                build.

    game throwDiceNextTurn.
    game throwDiceNextTurn. "Ambos terminan en la posición 2 (casillero normal)"
    
    game instantCard: (Repeat new affectsShipWithName: 'two') from: 'two'.

    "Las posiciones deben permanecer intactas ya que el casillero no tenía efecto"
    self assert: ((game spaceshipNamed: 'one') at:'position') equals: 2.
    self assert: ((game spaceshipNamed: 'two') at:'position') equals: 2.
]

{ #category : 'tests' }
InstantCardsTest >> test021CancellationThrowsErrorIfNoPermanentCardsAreActive [

	| ships dicePool game deckMock |
	ships := {
		         (Spaceship withName: 'Ship1').
		         (Spaceship withName: 'Ship2') }.

	deckMock := DeckMock withSequence: {
			            Cancellation new.
			            Speed new.
			            Speed new.
			            Speed new }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withDeck: deckMock;
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        build.

	self
		should: [
				game
					instantCard: (Cancellation new withCardToCancel: Speed new)
					from: 'Ship1' ]
		raiseErrorWithMessageText:
		'Unable to use Cantellation card if no active cards are in game.'
]
