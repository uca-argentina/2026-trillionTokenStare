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
   | highestSpaceships |

   (aSpaceShipCollection) ifEmpty: [ ^ OrderedCollection new ].
   highestSpaceships := OrderedCollection new.
   aSpaceShipCollection do: [ :aSpaceship |
	   highestSpaceships ifEmpty: [ highestSpaceships add: aSpaceship ] ifNotEmpty: [
		   (aSpaceship isAheadOf: highestSpaceships first) ifTrue: [ highestSpaceships := OrderedCollection with: aSpaceship ]
		   ifFalse: [ (aSpaceship isInTheSamePositionAs: highestSpaceships first) ifTrue: [ highestSpaceships add: aSpaceship ]
			] 
		]
	].

   aSpaceShipCollection removeAll: highestSpaceships.
   ^ highestSpaceships.
   
]
