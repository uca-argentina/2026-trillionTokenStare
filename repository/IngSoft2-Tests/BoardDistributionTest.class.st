Class {
	#name : 'BoardDistributionTest',
	#superclass : 'ProjectTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardDistributionTest >> test012BoardDistribution [

	| numberOfSquares distributedBoard |
	numberOfSquares := 100.


	distributedBoard := BoardBuilder new
		                    withSquares: numberOfSquares;
		                    build.

	self assert: distributedBoard size equals: 100.
	self assert: (distributedBoard occurrencesOf: Square) equals: 30.
	self assert: (distributedBoard occurrencesOf: CardDropper ) equals: 10.
	self assert: (distributedBoard occurrencesOf: Wormhole) equals: 20.
	self assert: (distributedBoard occurrencesOf: Speedup) equals: 20.
	self assert: (distributedBoard occurrencesOf: Moonwalk) equals: 10.
	self assert: (distributedBoard occurrencesOf: HyperJump) equals: 8.
	self assert: (distributedBoard occurrencesOf: AtomicBomb) equals: 2
]
