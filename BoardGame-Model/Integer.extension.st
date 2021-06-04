Extension { #name : #Integer }

{ #category : #'*BoardGame-Model' }
Integer >> D [

	^ Die withSides: self
]

{ #category : #'*BoardGame-Model' }
Integer >> D: anAmountOfSides [

	AssertionChecker
		enforce: [ self > 0 ] 
		because: 'Dice must have at least one die.'
		raising: InstanceCreationFailed.
		
	^ (1 to: self - 1)
		inject: anAmountOfSides D
		into: [ :dice :step | dice + anAmountOfSides D ]
]
