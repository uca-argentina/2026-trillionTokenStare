Class {
	#name : 'DicePool',
	#superclass : 'Object',
	#instVars : [
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DicePool class >> validateCollectionOfDice: aCollectionOfDice [

	aCollectionOfDice isCollection ifFalse: [
		self error: 'Dice pool initializes with a collection of dice' ].
	(aCollectionOfDice allSatisfy: [ :each | each isKindOf: Dice ])
		ifFalse: [ self error: 'Dice pool initializes with a collection of dice' ]
]

{ #category : 'as yet unclassified' }
DicePool class >> withDice: aCollectionOfDice [

	self validateCollectionOfDice: aCollectionOfDice.
	^ self new initializeWithDice: aCollectionOfDice
]

{ #category : 'initialization' }
DicePool >> initializeWithDice: aCollectionOfDice [

	dice := aCollectionOfDice
]

{ #category : 'initialization' }
DicePool >> throw [

	| sumOfAllDiceThrown |
	sumOfAllDiceThrown := (dice collect: [ :i | i throw ]) sum.
	^ sumOfAllDiceThrown
]
