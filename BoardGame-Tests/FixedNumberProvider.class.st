Class {
	#name : #FixedNumberProvider,
	#superclass : #Object,
	#instVars : [
		'numberCollection'
	],
	#category : #'BoardGame-Tests'
}

{ #category : #'instance creation' }
FixedNumberProvider class >> workingWith: aNumberCollection [

	^ self new initializeWorkingWith: aNumberCollection 
]

{ #category : #initialization }
FixedNumberProvider >> initializeWorkingWith: aNumberCollection [ 

	numberCollection := CircularIterator cyclingOver: aNumberCollection
]

{ #category : #accessing }
FixedNumberProvider >> nextInt: aSidesAmount [

	| result |
	
	result := numberCollection current.
	numberCollection next.
	^ result
]
