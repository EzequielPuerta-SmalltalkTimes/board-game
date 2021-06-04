Class {
	#name : #Match,
	#superclass : #Object,
	#instVars : [
		'dice',
		'board',
		'allPlayers',
		'turnOrder',
		'positionsByPlayer',
		'matchInProgress',
		'rankingsByPlayer'
	],
	#category : #'BoardGame-Model'
}

{ #category : #'instance creation' }
Match class >> among: aPlayersCollection using: aDice over: aBoard [

	self assertAtLeastTwoPlayersIn: aPlayersCollection.
	
	^ self new 
		initializeAmong: aPlayersCollection
		using: aDice
		over: aBoard
]

{ #category : #'private - validation' }
Match class >> assertAtLeastTwoPlayersIn: aPlayersCollection [

	AssertionChecker
		enforce: [ aPlayersCollection size > 1 ]
		because: 'The match must have at least two players.'
		raising: InstanceCreationFailed 
]

{ #category : #accessing }
Match >> board [

	^ board
]

{ #category : #accessing }
Match >> dice [

	^ dice
]

{ #category : #'private - initialization' }
Match >> initializeAmong: aPlayersCollection
	using: aDice
	over: aBoard [
	
	allPlayers := aPlayersCollection.
	dice := aDice.
	board := aBoard.
	matchInProgress := true.
	self 
		initializePositionsByPlayer;
		initializeTurnOrder;
		updateRanking
]

{ #category : #'private - initialization' }
Match >> initializePositionsByPlayer [

	positionsByPlayer := 
		allPlayers
			inject: Dictionary new
			into: [ :positions :player |
				positions
					add: player -> 1;
				 	yourself ]
]

{ #category : #'private - initialization' }
Match >> initializeTurnOrder [

	turnOrder := CircularIterator cyclingOver: allPlayers
]

{ #category : #accessing }
Match >> isInProgress [

	^ matchInProgress
]

{ #category : #playing }
Match >> nextTurn [

	| currentPlayer currentPosition |
	
	currentPlayer := turnOrder current.
	currentPosition := (positionsByPlayer at: currentPlayer) + dice roll.
	currentPosition := 
		(currentPosition >= self board tilesAmount)
			ifTrue: [ 
				matchInProgress := false. 
				self board tilesAmount ]
			ifFalse: [ currentPosition ].
		
	positionsByPlayer at: currentPlayer put: currentPosition.
	self updateRanking.
	turnOrder next
]

{ #category : #accessing }
Match >> players [

	^ allPlayers
]

{ #category : #playing }
Match >> positionOf: aPlayer [ 

	^ positionsByPlayer at: aPlayer
]

{ #category : #'updating ranking' }
Match >> positionsListGroupedByPosition [

	^ (positionsByPlayer associations groupedBy: #position) associations
]

{ #category : #playing }
Match >> ranking [

	^ rankingsByPlayer
]

{ #category : #playing }
Match >> rankingOf: aPlayer [ 

	^ self ranking at: aPlayer 
]

{ #category : #'updating ranking' }
Match >> sortedGroupedPositions [

	^ (SortedCollection sortBlock: #key descending)
		addAll: self positionsListGroupedByPosition;
		yourself
]

{ #category : #'updating ranking' }
Match >> updateRanking [

	| currentRanking |
	
	currentRanking := 1.
	rankingsByPlayer := self sortedGroupedPositions
		inject: Dictionary new
		into: [ :ranking :groupedPositions | 
			groupedPositions value
				do: [ :playerPosition | ranking at: playerPosition player put: currentRanking ].
			currentRanking := currentRanking + groupedPositions value size.
			ranking ]
]

{ #category : #playing }
Match >> winner [

	AssertionChecker 
		refuse: [ self isInProgress ]
		because: 'There is no winner yet.'.
	
	^ self ranking keyAtValue: 1
]
