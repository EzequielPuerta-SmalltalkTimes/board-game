Class {
	#name : #PlayerPositionTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Tests'
}

{ #category : #tests }
PlayerPositionTest >> testCreation [

	| simon simonPosition |
	
	simon := Player named: 'Simon'.
	simonPosition := PlayerPosition for: simon at: 10.
	
	self 
		assert: simonPosition player equals: simon;
		assert: simonPosition position equals: 10
]

{ #category : #tests }
PlayerPositionTest >> testInvalidPosition [

	#(0 -10)
		do: [ :invalidPosition |
			self
				should: [ PlayerPosition for: (Player named: 'Sarqui') at: invalidPosition ]
				raise: InstanceCreationFailed
				withMessageText: 'Position must be strictly positive.' ]
]

{ #category : #tests }
PlayerPositionTest >> testPrintOn [

	| simon simonPosition |
	
	simon := Player named: 'Simon'.
	simonPosition := PlayerPosition for: simon at: 10.
	
	self assert: simonPosition printString equals: 'Simon is at 10'
]
