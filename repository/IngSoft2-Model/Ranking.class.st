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
   | aSpaceShipCollectionCopy currentMax extractedSpaceShips |

   aSpaceShipCollectionCopy := aSpaceShipCollection copy.

   (aSpaceShipCollectionCopy) ifNotEmpty: [
      currentMax := (aSpaceShipCollectionCopy collect: [ :ship | ship position ]) max.
      extractedSpaceShips := aSpaceShipCollectionCopy select: [ :ship | ship position = currentMax ].
      aSpaceShipCollectionCopy removeAllSuchThat: [ :ship | ship position = currentMax ].
      ^ extractedSpaceShips.
   ]; else: [
      ^ OrderedCollection new.
   ].
]
