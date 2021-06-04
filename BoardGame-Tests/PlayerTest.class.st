Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Tests'
}

{ #category : #tests }
PlayerTest >> testCreation [

	| simon |
	
	simon := Player named: 'Simon'.
	
	self assert: simon name equals: 'Simon'
]

{ #category : #tests }
PlayerTest >> testEquals [

	self 
		assert: (Player named: 'Simon')
		equals: (Player named: 'Simon').

	self
		deny: (Player named: 'Simon')
		equals: (Player named: 'Sarqui')
]

{ #category : #tests }
PlayerTest >> testInvalidCreation [

	self
		should: [ Player named: '' ]
		raise: InstanceCreationFailed 
		withMessageText: 'Player must have a name.'
]

{ #category : #tests }
PlayerTest >> testPlayerPositionCreation [

	| sarqui sarquiPosition |
	
	sarqui := Player named: 'Sarqui'.
	sarquiPosition := sarqui -> 10.
	
	self 
		assert: sarquiPosition player equals: sarqui;
		assert: sarquiPosition position equals: 10
]

{ #category : #tests }
PlayerTest >> testPrintOn [

	| sarqui |
	
	sarqui := Player named: 'Sarqui'.
	
	self assert: sarqui printString equals: 'Sarqui'
]
