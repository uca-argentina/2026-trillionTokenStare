Class {
	#name : 'DeckTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DeckTest >> test001ADeckProvidesACard [
	| deck card |
	deck := Deck new.
	card := deck drawCard.
	self assert: (card isKindOf: Card).
]

{ #category : 'tests' }
DeckTest >> test002ADeckProvidesARandomCardFromTheGame [
	| deck card validTypeCards |
	deck := Deck new.
	card := deck drawCard.
	validTypeCards := { Cancellation .Redo . Repeat . Acceleration . Overload . Speed } asOrderedCollection.
	self assert: ( validTypeCards anySatisfy: [ : aValidType | card isMemberOf: aValidType ] ).
]

{ #category : 'tests' }
DeckTest >> test003AMockDeckProvidesCardsInExpectedSequence [
	| mockDeck sequence |
	sequence := { Redo new. Speed new . Acceleration new } .
	mockDeck := DeckMock withSequence: sequence.
	1 to: sequence size do: [ :index |
			self assert: mockDeck drawCard equals: (sequence at: index) .
   ]
]

{ #category : 'tests' }
DeckTest >> test004BeforeGameStartsTheDeckGivesTwoCardsForEachPlayer [
	| mockDeck sequence spaceshipManager spaceships |
	sequence := { Redo new. Acceleration new . Speed new . Cancellation new } .
	mockDeck := DeckMock withSequence: sequence.
	spaceships := { Spaceship withName: 'player_1' . Spaceship withName: 'player_2' } .
	spaceshipManager := SpaceshipManager withSpaceships: spaceships .
	
	spaceshipManager giveTwoCardsToEachSpaceship: mockDeck.
	
	self assert:( (spaceshipManager locateSpaceShip: 'player_1') playCard: (sequence at: 1) ) equals: (sequence at: 1).
	self assert:( (spaceshipManager locateSpaceShip: 'player_1') playCard: (sequence at: 2) ) equals: (sequence at: 2).
	self assert:( (spaceshipManager locateSpaceShip: 'player_2') playCard: (sequence at: 3) ) equals: (sequence at: 3).
	self assert:( (spaceshipManager locateSpaceShip: 'player_2') playCard: (sequence at: 4) ) equals: (sequence at: 4).

	
	
	
	
	
]
