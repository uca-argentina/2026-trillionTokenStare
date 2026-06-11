Class {
	#name : 'HyperJumpEffectTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpEffectTest >> test010HyperJumpSquareWithParsecs [

	| ships boardBuilder game hyperJumpSquare allTurnsResults |
	hyperJumpSquare := HyperJump new withJumpsInParsecs: { 300. 200 }.
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
		        withSpaceships: ships;
		        withBoardBuilder: boardBuilder;
		        withDicepool:
			        (DicePool withDice:
					         { (DiceMock withSides: 4 andSequence: #( 1 )) });
		        build.


	allTurnsResults := {
		                   {
			                   { 'one'. 5 }.
			                   { 'two'. 1 } }.
		                   {
			                   { 'one'. 5 }.
			                   { 'two'. 4 } }.
		                   {
			                   { 'one'. 6 }.
			                   { 'two'. 4 } } }.
	self
		assert: (self positionOf: #( 'one' 'two' ) in: game afterTurns: 3)
		equals: allTurnsResults
]

{ #category : 'tests' }
HyperJumpEffectTest >> test015HyperJumpAppliesJumpsFromHighestToLowestEvenWhenInputListIsUnsorted [

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
HyperJumpEffectTest >> test016HyperJumpLoopsWhenTItRunsOurOfJumps [

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
HyperJumpEffectTest >> test019HyperJumpSquareWithLightYears [

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
