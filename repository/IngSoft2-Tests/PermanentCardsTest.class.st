Class {
	#name : 'PermanentCardsTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PermanentCardsTest >> test001EffectOfOverloadCardOverCertainShips [

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
PermanentCardsTest >> test002EffectOfSpeedCardOverCertainShips [

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
PermanentCardsTest >> test003EffectOfAccelerationCardOverCertainShips [

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
PermanentCardsTest >> test004EffectOfManyActivePermanentCardsOverCertainShips [

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
PermanentCardsTest >> test005PlayerInputsCardThatDoesNotPosess [

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
			game permanentCard: (Overload new affectsShipWithName: 'Ship2') from: 'Ship1'.
	      game throwDiceNextTurn ]
		raiseErrorWithMessageText:
		'Ship can not play a card that doesnt posess'
]

{ #category : 'tests' }
PermanentCardsTest >> test006PlayerPlaysAccelerationCardAndItAffectsAllPlayers [

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

	game permanentCard: Acceleration new from: 'Ship1'.
	 2 timesRepeat: [ game throwDiceNextTurn ].

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 6 ).
				#( 'Ship2' 6 ) }
]

{ #category : 'tests' }
PermanentCardsTest >> test007PlayerPlaysSpeedCardAndItAffectsItSelf [

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

	game permanentCard: (Speed new affectsShipWithName: 'Ship1') from: 'Ship1'.
	3 timesRepeat: [ game throwDiceNextTurn ].
	

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 11 ).
				#( 'Ship2' 5 ) }
]

{ #category : 'tests' }
PermanentCardsTest >> test008PlayerPlaysOverloadCardAndItAffectsTheOtherPlayer [

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

	game permanentCard: (Overload new affectsShipWithName: 'Ship2') from: 'Ship1'.
	3 timesRepeat: [ game throwDiceNextTurn ].

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 9 ).
				#( 'Ship2' 3 ) }
]
