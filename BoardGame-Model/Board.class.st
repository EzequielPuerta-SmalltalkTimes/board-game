Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tilesAmount'
	],
	#category : #'BoardGame-Model'
}

{ #category : #'instance creation' }
Board class >> withTiles: aNumberOfTiles [

	AssertionChecker 
		enforce: [ aNumberOfTiles >= 2 ]
		because: 'A board must have two or more tiles.'
		raising: InstanceCreationFailed.
		
	^ self new initializeWithTiles: aNumberOfTiles
]

{ #category : #'private - initialization' }
Board >> initializeWithTiles: aNumberOfTiles [

	tilesAmount := aNumberOfTiles 
]

{ #category : #printing }
Board >> printOn: aStream [

	aStream
		nextPutAll: 'Board with ';
		print: self tilesAmount;
		nextPutAll: ' tiles'
]

{ #category : #accessing }
Board >> tilesAmount [

	^ tilesAmount
]
