Class {
	#name : 'MoonwalkTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonwalkTest >> test001BoardExecutesMoonwalkActionOnSpaceShip [

	| preloadedDice dicePool game listOfShips boardBuilder ships |
	preloadedDice := DiceMock withSides: 6 andSequence: #( 4 4 5 ).
	dicePool := DicePool withDice: { preloadedDice }.
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Moonwalk new.
			                Square new }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.

	game := GameBuilder new
		        withDicepool: dicePool;
		        withBoardBuilder: boardBuilder;
		        withSpaceships: ships;
		        build.

	game throwDiceNextTurn.
	game throwDiceNextTurn.
	game throwDiceNextTurn.

	listOfShips := {
		               { 'one'. 2 }.
		               { 'two'. 2 }.
		               { 'three'. 6 } }.

	self
		assert: (self positionOf: #( 'one' 'two' 'three' ) in: game)
		equals: listOfShips
]

{ #category : 'tests' }
MoonwalkTest >> test002RandomMoonwalksHaveVaryingBacktracks [
        | moonwalks backtracks |
        moonwalks := (1 to: 100) collect: [ :i |
                Moonwalk new atPosition: i; withParsecs: 100; withBacktrack: (2 to: 6) atRandom. ].
        backtracks := (moonwalks collect: [ :m | m backtrack ]) asSet.
        self assert: backtracks size > 1
]

{ #category : 'tests' }
MoonwalkTest >> test003MoonwalkBacktrackShouldBePositive [
   self
      should: [ Moonwalk new withBacktrack: 0 ]
      raiseErrorWithMessageText: 'Backtrack must be greater than 0'
]
