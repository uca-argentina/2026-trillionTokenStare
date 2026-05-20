Class {
	#name : 'RankingTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RankingTest >> test001youCanAskForTheRankOfTheThreeBestSpaceShipsByHowFarTheyHaveBeenMoving [
	| listOfShips rakingExpexted ranking rankingActually|
	listOfShips := {
		               (Spaceship withName: 1 andPosition: 4).
				         (Spaceship withName: 2 andPosition: 9).
		               (Spaceship withName: 3 andPosition: 5).
		               (Spaceship withName: 4 andPosition: 6) } asOrderedCollection .
	ranking := Ranking new.
	
   rakingExpexted := Dictionary new.
   rakingExpexted 
       at: #first put: {listOfShips at: 2} asOrderedCollection ;
       at: #second put: {listOfShips at: 4} asOrderedCollection;
       at: #third put: {listOfShips at: 3} asOrderedCollection
   .
   rankingActually := ranking bestThreeSpaceShips: listOfShips.

   self assert: rakingExpexted equals: rankingActually
]

{ #category : 'tests' }
RankingTest >> test002whenMoreThanTwoSpacesShipsShareTheSamePositionAndTheyAreInTheRankingThenTheyShareThePositionInTheRankingToo [
	| listOfShips rakingExpexted ranking rankingActually|
	listOfShips := {
		               (Spaceship withName: 1 andPosition: 11).
				         (Spaceship withName: 2 andPosition: 12).
		               (Spaceship withName: 3 andPosition: 13).
				         (Spaceship withName: 4 andPosition: 13).
				         (Spaceship withName: 5 andPosition: 13).
		               (Spaceship withName: 6 andPosition: 12).
		               (Spaceship withName: 7 andPosition: 10) } asOrderedCollection .
	ranking := Ranking new.
	
   rakingExpexted := Dictionary new.
   rakingExpexted 
       at: #first put:{ listOfShips at: 3.
                        listOfShips at: 4. 
                        listOfShips at: 5. }asOrderedCollection;
       at: #second put: { listOfShips at: 2.
                          listOfShips at: 6. }asOrderedCollection;
       at: #third put: {listOfShips at: 1}asOrderedCollection 
   .
   rankingActually := ranking bestThreeSpaceShips: listOfShips.

   self assert: rakingExpexted equals: rankingActually
]

{ #category : 'tests' }
RankingTest >> test003whenThaSpaceShipAreInSrartFirstPositionThenTheyAreTecnicallyInTheFirstPlace [
	| listOfShips rakingExpexted ranking rankingActually|
	listOfShips := {
		               (Spaceship withName: 1 andPosition: 1).
				         (Spaceship withName: 2 andPosition: 1).
		               (Spaceship withName: 3 andPosition: 1).
				         (Spaceship withName: 4 andPosition: 1).
   } asOrderedCollection .
	ranking := Ranking new.
	
   rakingExpexted := Dictionary new.
   rakingExpexted 
       at: #first put:listOfShips;
       at: #second put: OrderedCollection new;
       at: #third put: OrderedCollection new
   .
   rankingActually := ranking bestThreeSpaceShips: listOfShips.

   self assert: rakingExpexted equals: rankingActually
]
