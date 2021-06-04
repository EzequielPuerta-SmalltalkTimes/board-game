Class {
	#name : #PlayerPosition,
	#superclass : #Object,
	#instVars : [
		'player',
		'position'
	],
	#category : #'BoardGame-Model'
}

{ #category : #'private - validation' }
PlayerPosition class >> assertIsPositive: aBoardPosition [
	
	AssertionChecker
		enforce: [ aBoardPosition strictlyPositive ]
		because: 'Position must be strictly positive.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
PlayerPosition class >> for: aPlayer at: aBoardPosition [

	self assertIsPositive: aBoardPosition.
	^ self new initializeFor: aPlayer at: aBoardPosition
]

{ #category : #initialization }
PlayerPosition >> initializeFor: aPlayer at: aBoardPosition [

	player := aPlayer.
	position := aBoardPosition 
]

{ #category : #associations }
PlayerPosition >> key [

	^ self player
]

{ #category : #accessing }
PlayerPosition >> player [

	^ player
]

{ #category : #accessing }
PlayerPosition >> position [ 

	^ position
]

{ #category : #printing }
PlayerPosition >> printOn: aStream [

	aStream
		print: self player;
		nextPutAll: ' is at ';
		print: self position
]

{ #category : #associations }
PlayerPosition >> value [

	^ self position
]

{ #category : #evaluating }
PlayerPosition >> value: aBoardPosition [ 

	position := aBoardPosition
]
