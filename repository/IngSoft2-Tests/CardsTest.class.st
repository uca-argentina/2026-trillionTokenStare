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
		                 applyEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyEffectOn: ships last
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
		                 applyEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyEffectOn: ships last
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
		                 applyEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := card
		                 applyEffectOn: ships last
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 9.
	self assert: resultInShip2 equals: 9
]

{ #category : 'tests' }
CardsTest >> test004ActiveCards [

	| ships dicePool resultInShip1 resultInShip2 activeCards |
	"
	las cartas son una propiedad que guardan las naves, entonces un manager podria guardar las cartas junto a las naves.
	las cartas activas pertenecen al juego pero las maneja el manager
	"
	dicePool := DicePool withDice: {
			            (DiceMock withSides: 4 andSequence: #( 4 )).
			            (DiceMock withSides: 4 andSequence: #( 4 )) }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two') }.

	activeCards := CardManager new withActiveCards: {
			               Acceleration new.
			               (Speed new affectsShipWithName: 'one').
			               (Overload new affectsShipWithName: 'two') }.

	resultInShip1 := activeCards
		                 applyEffectOn: ships first
		                 overThrow: dicePool throw.
	resultInShip2 := activeCards
		                 applyEffectOn: ships last
		                 overThrow: dicePool throw.

	self assert: resultInShip1 equals: 10.
	self assert: resultInShip2 equals: 7
]
