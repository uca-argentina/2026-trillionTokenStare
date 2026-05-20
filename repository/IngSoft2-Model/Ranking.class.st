Class {
	#name : 'Ranking',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Ranking >> bestThreeSpaceShips: aSpaceShipCollection [
   | aSpaceShipRankedDictionary aSpaceShipCollectionCopy first second third |
   aSpaceShipCollectionCopy := aSpaceShipCollection copy.
   aSpaceShipCollectionCopy := aSpaceShipCollectionCopy sorted: [ :shipA :shipB | shipA position > shipB position ].
   first :=aSpaceShipCollectionCopy at: 1.
   second :=aSpaceShipCollectionCopy at: 2.
   third :=aSpaceShipCollectionCopy at: 3.
   aSpaceShipRankedDictionary := Dictionary new.
   aSpaceShipRankedDictionary 
      at: #first put: first;   
      at: #second put: second ;
      at: #third put: third.
	^ aSpaceShipRankedDictionary
]
