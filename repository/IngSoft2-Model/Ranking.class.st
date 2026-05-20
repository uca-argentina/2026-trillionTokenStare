Class {
	#name : 'Ranking',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Ranking >> bestThreeSpaceShips: aSpaceShipCollection [
   | aSpaceShipRankedDictionary aSpaceShipCollectionCopy currentMax first second third |

   aSpaceShipCollectionCopy := aSpaceShipCollection copy.
   
   first:= OrderedCollection new.
   second:= OrderedCollection new.
   third:= OrderedCollection new.

   (aSpaceShipCollectionCopy) ifNotEmpty: [
      currentMax := (aSpaceShipCollectionCopy collect: [ :ship | ship position ]) max.
      first := aSpaceShipCollectionCopy select: [ :ship | ship position = currentMax ].
      aSpaceShipCollectionCopy removeAllSuchThat: [ :ship | ship position = currentMax ].
   ].
   (aSpaceShipCollectionCopy) ifNotEmpty: [
      currentMax := (aSpaceShipCollectionCopy collect: [ :ship | ship position ]) max.
      second := aSpaceShipCollectionCopy select: [ :ship | ship position = currentMax ].
      aSpaceShipCollectionCopy removeAllSuchThat: [ :ship | ship position = currentMax ].
   ].
   (aSpaceShipCollectionCopy) ifNotEmpty: [
      currentMax := (aSpaceShipCollectionCopy collect: [ :ship | ship position ]) max.
      third := aSpaceShipCollectionCopy select: [ :ship | ship position = currentMax ].
      aSpaceShipCollectionCopy removeAllSuchThat: [ :ship | ship position = currentMax ].
   ].
   aSpaceShipRankedDictionary := Dictionary new.
   aSpaceShipRankedDictionary 
      at: #first put: first;   
      at: #second put: second ;
      at: #third put: third.
	^ aSpaceShipRankedDictionary
	
]
