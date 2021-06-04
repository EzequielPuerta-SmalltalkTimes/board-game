Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'dieCollection'
	],
	#category : #'BoardGame-Model'
}

{ #category : #'instance creation' }
Dice class >> with: aDie [

	^ self withAll: (Bag with: aDie)
]

{ #category : #'instance creation' }
Dice class >> with: aDie with: anotherDie [

	^ self withAll: (Bag with: aDie with: anotherDie)
]

{ #category : #'instance creation' }
Dice class >> with: aFirstDie with: aSecondDie with: aThirdDie [

	^ self withAll: (Bag with: aFirstDie with: aSecondDie with: aThirdDie)
]

{ #category : #'instance creation' }
Dice class >> with: aFirstDie with: aSecondDie with: aThirdDie with: aFourthDie [

	^ self withAll: (Bag with: aFirstDie with: aSecondDie with: aThirdDie with: aFourthDie)
]

{ #category : #'instance creation' }
Dice class >> withAll: aDieCollection [

	AssertionChecker
		enforce: [ aDieCollection isNotEmpty ] 
		because: 'Dice must have at least one die.'
		raising: InstanceCreationFailed.
		
	^ self new initializeWithAll: aDieCollection
]

{ #category : #adding }
Dice >> + anObject [

	^ anObject addDice: self
]

{ #category : #comparing }
Dice >> = anObject [

	^ (anObject isA: self class) and: [ anObject dieCollection = self dieCollection ]
]

{ #category : #adding }
Dice >> addDice: aDiceToAdd [

	self dieCollection addAll: aDiceToAdd dieCollection
]

{ #category : #adding }
Dice >> addDie: aDieToAdd [

	self dieCollection add: aDieToAdd
]

{ #category : #accessing }
Dice >> dieCollection [

	^ dieCollection
]

{ #category : #comparing }
Dice >> hash [ 

	^ self dieCollection hash
]

{ #category : #'private - initialization' }
Dice >> initializeWithAll: aDieCollection [

	dieCollection := aDieCollection 
]

{ #category : #printing }
Dice >> printOn: aStream [

	(CollectionFormatter separatingWith: $;) format: self dieCollection on: aStream
]

{ #category : #accessing }
Dice >> roll [

	^ self dieCollection sumNumbers: #roll
]

{ #category : #accessing }
Dice >> size [

	^ self dieCollection size
]
