Class {
	#name : 'ProjectTestCase',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ProjectTestCase >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage ]
]
