Class {
	#name : 'HyperJumpEffectTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpEffectTest >> test001HyperJumpSquareWithCustomParsecsAndThreeShips [

	| ships boardBuilder game customHyperJumpSquare allTurnsResults |
	customHyperJumpSquare := HyperJump new withJumpsInParsecs:
		                         { 450. 300. 150 }. " { 450//100 -> 4 squares . 300//100 -> 3 squares . 150//100 -> 1 square}"
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.

	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new. "1"
			                customHyperJumpSquare. "2"
			                Square new. "3"
			                Square new. "4"
			                Square new. "5"
			                Square new. "6"
			                Square new. "7"
			                Square new. "8"
			                Square new. "9"
			                Square new "10" }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.

	allTurnsResults := {
		                   {
			                   { 'one'. 6 }. "2 + 4 "
			                   { 'two'. 1 }.
			                   { 'three'. 1 } }.
		                   {
			                   { 'one'. 6 }.
			                   { 'two'. 5 }. "2 + 3 "
			                   { 'three'. 1 } }.
		                   {
			                   { 'one'. 6 }.
			                   { 'two'. 5 }.
			                   { 'three'. 3 } } }. "2 + 1"

	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' ) in: game afterTurns: 3)
		equals: allTurnsResults
]

{ #category : 'tests' }
HyperJumpEffectTest >> test002HyperJumpAppliesJumpsFromHighestToLowestEvenWhenInputListIsUnsorted [

	| finalPositions boardBuilder game ships |
	
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.
		
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                HyperJump new withJumpsInParsecs: {100 . 300 . 200}.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.
		
	finalPositions := {
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 1 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 3 } } }.


	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' ) in: game afterTurns: 3)
		equals: finalPositions
]

{ #category : 'tests' }
HyperJumpEffectTest >> test003HyperJumpLoopsWhenTItRunsOurOfJumps [

	| finalPositions boardBuilder game ships |
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three').
		         (Spaceship withName: 'four') }.

	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                (HyperJump new withJumpsInParsecs: { 300. 200. 100 }).
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	game := GameBuilder new
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.

	finalPositions := {
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 1 }.
			                  { 'three'. 1 }.
			                  { 'four'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 1 }.
			                  { 'four'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 3 }.
			                  { 'four'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 3 }.
			                  { 'four'. 5 } } }.


	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' 'four' ) in: game afterTurns: 4)
		equals: finalPositions
]

{ #category : 'tests' }
HyperJumpEffectTest >> test004HyperJumpSquareWithLightYears [

	| finalPositions ships boardBuilder game hyperJumpSquare |
	hyperJumpSquare := HyperJump new withJumpsInLightYears: { 101. 67 }.
	ships := {
		         (Spaceship withName: 'one').
		         (Spaceship withName: 'two').
		         (Spaceship withName: 'three') }.
	boardBuilder := MockBoardBuilder new withEffects: {
			                Square new.
			                hyperJumpSquare.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new.
			                Square new }.

	game := GameBuilder new
		        withLightYears: 334;
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.
	finalPositions := {
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 1 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 1 } }.
		                  {
			                  { 'one'. 5 }.
			                  { 'two'. 4 }.
			                  { 'three'. 5 } } }.


	self
		assert:
		(self positionOf: #( 'one' 'two' 'three' ) in: game afterTurns: 3)
		equals: finalPositions
]

{ #category : 'tests' }
HyperJumpEffectTest >> test005HyperJumpValuesShouldBePositive [

	self
		should: [ HyperJump new withJumpsInParsecs: { -100 . 0 } ]
	   raiseErrorWithMessageText: 'HyperJump distances must be greater than 0'
]
