Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'sidesAmount',
		'numberProvider'
	],
	#category : #'BoardGame-Model'
}

{ #category : #'private - validation' }
Die class >> assertValidAmountOfSides: aNumberOfSides [
	AssertionChecker
		enforce: [ aNumberOfSides >= 2 ]
		because: 'A die must have two or more sides.'
		raising: InstanceCreationFailed
]

{ #category : #default }
Die class >> defaultNumberProvider [

	^ Random new useClockBasedSeed
]

{ #category : #'instance creation' }
Die class >> withSides: aNumberOfSides [ 
	
	^ self withSides: aNumberOfSides using: self defaultNumberProvider
]

{ #category : #'instance creation' }
Die class >> withSides: aNumberOfSides using: aNumberProvider [

	self assertValidAmountOfSides: aNumberOfSides.
	^ self new initializeWithSides: aNumberOfSides using: aNumberProvider
]

{ #category : #adding }
Die >> + anObject [

	^ anObject addDie: self
]

{ #category : #comparing }
Die >> = anObject [

	^ (anObject isA: self class) and: [ anObject sidesAmount = self sidesAmount ]
]

{ #category : #adding }
Die >> addDice: aDiceToAdd [

	^ aDiceToAdd addDie: self
]

{ #category : #adding }
Die >> addDie: aDieToAdd [

	^ Dice with: self with: aDieToAdd
]

{ #category : #comparing }
Die >> hash [

	^ self sidesAmount hash
]

{ #category : #'private - initialization' }
Die >> initializeWithSides: aNumberOfSides using: aNumberProvider [

	sidesAmount := aNumberOfSides.
	numberProvider := aNumberProvider
]

{ #category : #printing }
Die >> printOn: aStream [

	aStream
		nextPutAll: 'Die with ';
		print: self sidesAmount;
		nextPutAll: ' sides'
]

{ #category : #accessing }
Die >> roll [ 

	^ numberProvider nextInt: self sidesAmount
]

{ #category : #accessing }
Die >> sidesAmount [

	^ sidesAmount 
]
