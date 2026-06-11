Class {
	#name : 'ProjectTestCase',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ProjectTestCase >> assertDictionary: unDiccionario contains: diccionarioEsperado [

	| cumpleTodo |
	"Transformamos el diccionario esperado en una colección de asociaciones estándar"
	cumpleTodo := diccionarioEsperado associations allSatisfy: [
			              :asociacion |
			              | clave valorEsperado |
			              clave := asociacion key.
			              valorEsperado := asociacion value.

			              "Buscamos la clave en el diccionario del juego y comparamos el valor"
			              (unDiccionario at: clave ifAbsent: [ nil ])
			              = valorEsperado ].

	self assert: cumpleTodo
]

{ #category : 'asserting' }
ProjectTestCase >> assertDictionary: unDiccionario contieneDato: diccionarioEsperado [

	| cumpleTodo |
	"Recorremos las asociaciones (clave-valor) del diccionario esperado"
	cumpleTodo := diccionarioEsperado associationsAllSatisfy: [
			              :asociacion |
			              | clave valorEsperado |
			              clave := asociacion key.
			              valorEsperado := asociacion value.

			              "Verificamos que en el diccionario real coincida el valor"
			              (unDiccionario at: clave ifAbsent: [ nil ])
			              = valorEsperado ].

	self assert: cumpleTodo
]

{ #category : 'asserting' }
ProjectTestCase >> positionOf: spaceshipNames in: game [

	^ spaceshipNames collect: [ :name |
			  {
				  name.
				  ((game spaceshipNamed: name) at:#position)} ]
]

{ #category : 'asserting' }
ProjectTestCase >> positionOf: spaceshipNames in: game afterTurns: numberOfTurns [

	^ (1 to: numberOfTurns) collect: [ :turn |
			  game throwDiceNextTurn.
			  self positionOf: spaceshipNames in: game ]
]

{ #category : 'asserting' }
ProjectTestCase >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage ]
]
