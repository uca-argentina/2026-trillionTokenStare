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
		                 applyPermanentEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyPermanentEffectOn: ships last
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
		                 applyPermanentEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyPermanentEffectOn: ships last
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
		                 applyPermanentEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyPermanentEffectOn: ships last
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
		                 applyPermanentEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := activeCards
		                 applyPermanentEffectOn: ships last
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 10.
	self assert: resultInShip2 equals: 7
]

{ #category : 'tests' }
CardsTest >> test005PlayerInputsCardThatDoesNotPosess [

	| ships dicePool game |
	ships := {
		         (Spaceship withName: 'Ship1' andPosition: 1 andCards: {
				          Acceleration new.
				          Card new }).
		         (Spaceship withName: 'Ship2' andPosition: 1 andCards: {
				          Card new.
				          Card new }) }.
	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.
	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        build.



	self
		should: [
				game nextPlayerThrowsDiceAndUsesPermanentCard:
					(Overload new affectsShipWithName: 'Ship2') ]
		raiseErrorWithMessageText:
		'Ship can not play a card that doesnt posess'
]

{ #category : 'tests' }
CardsTest >> test006PlayerPlaysAccelerationCardAndItAffectsAllPlayers [

	| ships dicePool game |
	ships := {
		         (Spaceship withName: 'Ship1' andPosition: 1 andCards: {
				          Acceleration new.
				          Card new }).
		         (Spaceship withName: 'Ship2' andPosition: 1 andCards: {
				          Card new.
				          Card new }) }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        build.

	game nextPlayerThrowsDiceAndUsesPermanentCard: Acceleration new.
	game nextPlayerThrowsDice.

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 6 ).
				#( 'Ship2' 6 ) }
]

{ #category : 'tests' }
CardsTest >> test007PlayerPlaysSpeedCardAndItAffectsItSelf [

	| ships dicePool game |
	ships := {
		         (Spaceship withName: 'Ship1' andPosition: 1 andCards: {
				          Speed new.
				          Card new }).
		         (Spaceship withName: 'Ship2' andPosition: 1 andCards: {
				          Card new.
				          Card new }) }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        withSquares: 20;
		        build.

	game nextPlayerThrowsDiceAndUsesPermanentCard:
		(Speed new affectsShipWithName: 'Ship1').
	game nextPlayerThrowsDice.
	game nextPlayerThrowsDice.

	self
		assert: (self positionOf: #( 'Ship1' 'Ship2' ) in: game)
		equals: {
				#( 'Ship1' 11 ).
				#( 'Ship2' 5 ) }
]

{ #category : 'tests' }
CardsTest >> test008PlayerPlaysOverloadCardAndItAffectsTheOtherPlayer [

	| ships dicePool game |
	ships := {
		         (Spaceship withName: 'Ship1' andPosition: 1 andCards: {
				          Overload new.
				          Card new }).
		         (Spaceship withName: 'Ship2' andPosition: 1 andCards: {
				          Card new.
				          Card new }) }.

	dicePool := DicePool withDice:
		            { (DiceMock withSides: 4 andSequence: #( 4 )) }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withDicepool: dicePool;
		        build.

	game nextPlayerThrowsDiceAndUsesPermanentCard:
		(Overload new affectsShipWithName: 'Ship2').
	game nextPlayerThrowsDice.
	game nextPlayerThrowsDice.

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
		                 applyPermanentEffectOn: ships first
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 9"Acceleration was cancelled"
]
