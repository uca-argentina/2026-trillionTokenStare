Class {
	#name : 'Ranking',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'behavior' }
Ranking >> bestThreeSpaceShips: aSpaceShipCollection [
   | aSpaceShipRankedDictionary aSpaceShipCollectionCopy  first second third |

   aSpaceShipCollectionCopy := aSpaceShipCollection copy.
   
   first:= self extractSpaceShipsByHighestPosition: aSpaceShipCollectionCopy.
   second:= self extractSpaceShipsByHighestPosition: aSpaceShipCollectionCopy.
   third:= self extractSpaceShipsByHighestPosition: aSpaceShipCollectionCopy.

   aSpaceShipRankedDictionary := Dictionary new.
   aSpaceShipRankedDictionary 
      at: #first put: first;   
      at: #second put: second ;
      at: #third put: third.
	^ aSpaceShipRankedDictionary
	
]

{ #category : 'private - extraction' }
Ranking >> extractSpaceShipsByHighestPosition: aSpaceShipCollection [
   | currentMax extractedSpaceShips |

   (aSpaceShipCollection) ifNotEmpty: [
      currentMax := (aSpaceShipCollection collect: [ :ship | ship position ]) max.
      extractedSpaceShips := aSpaceShipCollection select: [ :ship | ship position = currentMax ].
      aSpaceShipCollection removeAllSuchThat: [ :ship | ship position = currentMax ].
      ^ extractedSpaceShips.
   ].
   ^ OrderedCollection new.
]
