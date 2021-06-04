Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'BoardGame-Model'
}

{ #category : #'private - validation' }
Player class >> assertNotEmpty: aName [

	AssertionChecker 
		enforce: [ aName isNotEmpty ]
		because: 'Player must have a name.'
		raising: InstanceCreationFailed 
]

{ #category : #'instance creation' }
Player class >> named: aName [

	self assertNotEmpty: aName.
	^ self new initializeNamed: aName
]

{ #category : #associating }
Player >> -> aBoardPosition [

	^ PlayerPosition for: self at: aBoardPosition
]

{ #category : #initialization }
Player >> = aPlayer [

	^ (aPlayer isA: self class) and: [ aPlayer name = self name ]
]

{ #category : #initialization }
Player >> hash [ 

	^ self name hash
]

{ #category : #initialization }
Player >> initializeNamed: aName [

	name := aName
]

{ #category : #accessing }
Player >> name [

	^ name
]

{ #category : #printing }
Player >> printOn: aStream [

	aStream nextPutAll: self name
]
