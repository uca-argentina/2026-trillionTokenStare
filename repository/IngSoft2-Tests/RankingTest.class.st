Class {
	#name : 'RankingTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RankingTest >> test001youCanAskForTheRankOfTheThreeBestSpaceShipsByHowFarTheyHaveBeenMoving [

	| listOfShips rakingExpexted ranking rankingActually |
	listOfShips := {
		               ((Spaceship withName: '1') movesForward: 3).
		               ((Spaceship withName: '2') movesForward: 8).
		               ((Spaceship withName: '3') movesForward: 4).
		               ((Spaceship withName: '4') movesForward: 5) }
		               asOrderedCollection.
	ranking := Ranking new.

	rakingExpexted := Dictionary new.
	rakingExpexted
		at: #first put: { (listOfShips at: 2) } asOrderedCollection;
		at: #second put: { (listOfShips at: 4) } asOrderedCollection;
		at: #third put: { (listOfShips at: 3) } asOrderedCollection.
	rankingActually := ranking bestThreeSpaceShips: listOfShips.

	self assert: rankingActually equals: rakingExpexted
]

{ #category : 'tests' }
RankingTest >> test002whenMoreThanTwoSpacesShipsShareTheSamePositionAndTheyAreInTheRankingThenTheyShareThePositionInTheRankingToo [

	| listOfShips rakingExpexted ranking rankingActually |
	listOfShips := {
		               ((Spaceship withName: '1') movesForward: 10).
		               ((Spaceship withName: '2') movesForward: 11).
		               ((Spaceship withName: '3') movesForward: 12).
		               ((Spaceship withName: '4') movesForward: 12).
		               ((Spaceship withName: '5') movesForward: 12).
		               ((Spaceship withName: '6') movesForward: 11).
		               ((Spaceship withName: '7') movesForward: 9) }
		               asOrderedCollection.
	ranking := Ranking new.

	rakingExpexted := Dictionary new.
	rakingExpexted
		at: #first put: {
				(listOfShips at: 3).
				(listOfShips at: 4).
				(listOfShips at: 5) } asOrderedCollection;
		at: #second put: {
				(listOfShips at: 2).
				(listOfShips at: 6) } asOrderedCollection;
		at: #third put: { (listOfShips at: 1) } asOrderedCollection.
	rankingActually := ranking bestThreeSpaceShips: listOfShips.

	self assert: rankingActually equals: rakingExpexted
]

{ #category : 'tests' }
RankingTest >> test003whenThaSpaceShipAreInSrartFirstPositionThenTheyAreTecnicallyInTheFirstPlace [

	| listOfShips rakingExpexted ranking rankingActually |
	listOfShips := {
		               (Spaceship withName: '1').
		               (Spaceship withName: '2').
		               (Spaceship withName: '3').
		               (Spaceship withName: '4') } asOrderedCollection.
	ranking := Ranking new.

	rakingExpexted := Dictionary new.
	rakingExpexted
		at: #first put: listOfShips;
		at: #second put: OrderedCollection new;
		at: #third put: OrderedCollection new.
	rankingActually := ranking bestThreeSpaceShips: listOfShips.

	self assert: rankingActually equals: rakingExpexted
]

{ #category : 'tests' }
RankingTest >> test020GameCanProvideTheCurrentRankingOfShips [

	| preloadedDice dicePool game ranking namesAt |
	preloadedDice := DiceMock withSides: 4 andSequence: #( 4 3 2 ).
	dicePool := DicePool withDice: { preloadedDice }.
	game := GameBuilder new
		        withSpaceships:
			        ((1 to: 3) collect: [ :number |
					         Spaceship withName: number asString ]);
		        withDicepool: dicePool;
		        build.

	3 timesRepeat: [ game throwDiceNextTurn ].

	ranking := game ranking.
	namesAt := [ :rank |
	           ((ranking at: rank) collect: [ :ship | ship name ])
		           asArray ].
	self assert: (namesAt value: #first) equals: #( '1' ).
	self assert: (namesAt value: #second) equals: #( '2' ).
	self assert: (namesAt value: #third) equals: #( '3' )
]
