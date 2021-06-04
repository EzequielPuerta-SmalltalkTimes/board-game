Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Tests'
}

{ #category : #tests }
DieTest >> testBiggerDieCreation [

	| sidesAmount die |
	
	sidesAmount := 12.
	die := Die withSides: sidesAmount.
	self assert: die sidesAmount equals: sidesAmount
]

{ #category : #tests }
DieTest >> testCommonDieCreation [

	| sidesAmount die |
	
	sidesAmount := 6.
	die := Die withSides: sidesAmount.
	self assert: die sidesAmount equals: sidesAmount
]

{ #category : #tests }
DieTest >> testCommonDieCreationWithDieNotation [

	self assert: 6 D sidesAmount equals: 6
]

{ #category : #tests }
DieTest >> testEquals [

	self 
		assert: (Die withSides: 6) equals: (1 D: 6);
		assert: (Die withSides: 6) equals: 6 D
]

{ #category : #tests }
DieTest >> testInvalidDieCreation [

	| invalidSidesAmounts |
	
	invalidSidesAmounts := Array with: 1 with: 0 with: -1 with: -6.
	
	invalidSidesAmounts do: [ :invalidSidesAmount |
		self
			should: [ Die withSides: invalidSidesAmount ]
			raise: InstanceCreationFailed
			withMessageText: 'A die must have two or more sides.' ]
]

{ #category : #tests }
DieTest >> testPrintOn [

	| sidesAmount die |
	
	sidesAmount := 6.
	die := Die withSides: sidesAmount.
	self 
		assert: die printString 
		equals: ('Die with <1p> sides' expandMacrosWith: sidesAmount)
]

{ #category : #tests }
DieTest >> testRollFixedDie [

	| die |
	
	die := Die withSides: 6 using: (FixedNumberProvider workingWith: #(4 6 3 2)).
	
	self 
		assert: die roll equals: 4;
		assert: die roll equals: 6;
		assert: die roll equals: 3;
		assert: die roll equals: 2;
		assert: die roll equals: 4;
		assert: die roll equals: 6;
		deny: die roll equals: 6
]

{ #category : #tests }
DieTest >> testRollRandomDie [

	| rolls possibleResults die results |
	
	rolls := 1000.
	possibleResults := 1 to: 5.
	die := 5 D.
	results := Dictionary new.

	rolls timesRepeat: [ | result |
		result := die roll.
		self assert: possibleResults includes: result.
		results 
			at: result 
			ifPresent: [ :occurrences | results at: result put: occurrences + 1 ]
			ifAbsentPut: [1]].
		
	possibleResults do: [ :result | 
		self 
			assert: ((results at: result) / rolls) asFloat 
			closeTo: 0.20
			precision: 0.35 ]
]
