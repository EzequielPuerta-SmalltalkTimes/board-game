Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Tests'
}

{ #category : #tests }
DiceTest >> testDiceCreation [

	| dice |
	
	dice := Dice with: 4 D with: 5 D with: 6 D with: 5 D.
	self 
		assert: dice size equals: 4;
		assertCollection: dice dieCollection
			hasSameElements: (
				OrderedCollection 
					with: 6 D
					with: 5 D
					with: 5 D
					with: 4 D)
]

{ #category : #tests }
DiceTest >> testDiceCreationWithDiceNotation [

	| dice |
	
	dice := (1 D: 6) + (2 D: 5).
	self 
		assert: dice size equals: 3;
		assertCollection: dice dieCollection
			hasSameElements: (
				OrderedCollection 
					with: 6 D
					with: 5 D
					with: 5 D)
]

{ #category : #tests }
DiceTest >> testEquals [

	self 
		assert: (Dice with: 4 D with: 5 D with: 6 D with: 5 D)
		equals: 4 D + (2 D: 5) + 6 D
]

{ #category : #tests }
DiceTest >> testInvalidDiceCreation [

	self
		should: [ Dice withAll: Bag new ]
			raise: InstanceCreationFailed
			withMessageText: 'Dice must have at least one die.';
		should: [ 0 D: 6 ]
			raise: InstanceCreationFailed 
			withMessageText: 'Dice must have at least one die.'
]

{ #category : #tests }
DiceTest >> testSumDiceWithDice [

	self 
		assert: (Dice with: 6 D with: 5 D with: 5 D with: 4 D) 
			equals: (Dice with: 5 D with: 5 D) + (Dice with: 6 D with: 4 D);
		assert: (Dice with: 6 D with: 5 D with: 5 D with: 4 D)
			equals: (2 D: 5) + ((1 D: 6) + (1 D: 4))
]

{ #category : #tests }
DiceTest >> testSumDiceWithDie [

	self 
		assert: (Dice with: 6 D with: 5 D with: 5 D) equals: (Dice with: 5 D with: 5 D) + 6 D;
		assert: (Dice with: 6 D with: 5 D with: 5 D) equals: (2 D: 5) + 6 D;
		assert: (Dice with: 6 D with: 5 D with: 5 D) equals: (2 D: 5) + (1 D: 6)
]

{ #category : #tests }
DiceTest >> testSumDieWithDice [

	self 
		assert: (Dice with: 6 D with: 5 D with: 5 D) equals: 6 D + (Dice with: 5 D with: 5 D);
		assert: (Dice with: 6 D with: 5 D with: 5 D) equals: (1 D: 6) + (2 D: 5);
		assert: (Dice with: 6 D with: 5 D with: 5 D) equals: 6 D + (2 D: 5)
]

{ #category : #tests }
DiceTest >> testSumDieWithDie [

	self 
		assert: (Die withSides: 6) + (Die withSides: 5) equals: (Dice with: 6 D with: 5 D);
		assert: (Die withSides: 6) + (Die withSides: 5) equals: (1 D: 6) + (1 D: 5);
		assert: (Die withSides: 6) + (Die withSides: 5) equals: 6 D + 5 D
]
