Class {
	#name : #MatchTest,
	#superclass : #TestCase,
	#instVars : [
		'fourPlayers',
		'oneHundredTilesBoard'
	],
	#category : #'BoardGame-Tests'
}

{ #category : #asserting }
MatchTest >> assert: aPlayerCollection areAt: aPositionCollection during: aMatch [

	aPlayerCollection
		with: aPositionCollection
		do: [ :player :position | 
			self assert: (aMatch positionOf: player) equals: position ]
]

{ #category : #asserting }
MatchTest >> assert: aPlayerCollection rankAt: aRankingCollection during: aMatch [

	aPlayerCollection
		with: aRankingCollection 
		do: [ :player :ranking | 
			self assert: (aMatch rankingOf: player) equals: ranking ]
]

{ #category : #'test support' }
MatchTest >> fourPlayers [

	^ fourPlayers
]

{ #category : #'test support' }
MatchTest >> oneHundredTilesBoard [

	^ oneHundredTilesBoard
]

{ #category : #setup }
MatchTest >> setUp [

	fourPlayers := 
		#('Ezequiel' 'Yasmin' 'Lucia' 'Juanchi')
			collect: [ :name | Player named: name ].
	oneHundredTilesBoard := Board withTiles: 100
]

{ #category : #'test support' }
MatchTest >> sixSidedDieFixedIn: anIntegerCollection [

	^ Die 
		withSides: 6 
		using: (FixedNumberProvider workingWith: anIntegerCollection)
]

{ #category : #tests }
MatchTest >> test_1_NewMatch [

	| match |
	
	match := 
		Match 
			among: self fourPlayers 
			using: 6 D + 8 D 
			over: self oneHundredTilesBoard.
	
	self 
		assert: match players equals: self fourPlayers;
		assert: match dice equals: 6 D + 8 D;
		assert: match board equals: self oneHundredTilesBoard;
		assert: match isInProgress.
		
	self
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match
]

{ #category : #tests }
MatchTest >> test_2_InvalidMatch [

	self
		should: [ 
			Match 
				among: #()
				using: 6 D + 8 D 
				over: self oneHundredTilesBoard ]
		raise: InstanceCreationFailed 
		withMessageText: 'The match must have at least two players.'.
		
	self
		should: [ 
			Match 
				among: (OrderedCollection with: (Player named: 'Ezequiel'))
				using: 6 D + 8 D 
				over: self oneHundredTilesBoard ]
		raise: InstanceCreationFailed 
		withMessageText: 'The match must have at least two players.'
]

{ #category : #tests }
MatchTest >> test_3_FirstMoveUpdatesPositionAndRanking [

	| match dice |

	dice := Dice with: (self sixSidedDieFixedIn: #(5)).
	match := Match among: self fourPlayers using: dice over: self oneHundredTilesBoard.
		
	self
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match.
	
	match nextTurn.
	
	self
		assert: self fourPlayers rankAt: #(1 2 2 2) during: match;
		assert: self fourPlayers areAt: #(6 1 1 1) during: match
]

{ #category : #tests }
MatchTest >> test_4_TurnOrderIsEnforced [

	| match dice |

	dice := Dice with: (self sixSidedDieFixedIn: #(6 5 4 3 2 1)).
	match := Match among: self fourPlayers using: dice over: self oneHundredTilesBoard.
		
	self
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match.
	
	match nextTurn. "Dice sum 6, so Ezequiel moves to 1+6=7"
	self
		assert: self fourPlayers rankAt: #(1 2 2 2) during: match;
		assert: self fourPlayers areAt: #(7 1 1 1) during: match.
	
	match nextTurn. "Dice sum 5, so Yasmin moves to 1+5=6"
	self
		assert: self fourPlayers rankAt: #(1 2 3 3) during: match;
		assert: self fourPlayers areAt: #(7 6 1 1) during: match.
		
	match nextTurn. "Dice sum 4, so Lucia moves to 1+4=5"
	self
		assert: self fourPlayers rankAt: #(1 2 3 4) during: match;
		assert: self fourPlayers areAt: #(7 6 5 1) during: match.
		
	match nextTurn. "Dice sum 3, so Juanchi moves to 1+3=4"
	self
		assert: self fourPlayers rankAt: #(1 2 3 4) during: match;
		assert: self fourPlayers areAt: #(7 6 5 4) during: match.
		
	match nextTurn. "Dice sum 2, so Ezequiel moves to 7+2=9"
	self
		assert: self fourPlayers rankAt: #(1 2 3 4) during: match;
		assert: self fourPlayers areAt: #(9 6 5 4) during: match.
		
	match nextTurn. "Dice sum 1, so Yasmin moves to 6+1=7"
	self
		assert: self fourPlayers rankAt: #(1 2 3 4) during: match;
		assert: self fourPlayers areAt: #(9 7 5 4) during: match
]

{ #category : #tests }
MatchTest >> test_5_GameEnded [

	| match dice |

	dice := Dice with: (self sixSidedDieFixedIn: #(6 4 2 3 3)).
	match := Match among: self fourPlayers using: dice over: (Board withTiles: 10).
		
	self
		assert: match isInProgress;
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match.
	
	[ match isInProgress ] 
		whileTrue: [ match nextTurn ].
		
	self
		deny: match isInProgress;
		assert: self fourPlayers rankAt: #(1 2 4 3) during: match;
		assert: self fourPlayers areAt: #(10 5 3 4) during: match.
]

{ #category : #tests }
MatchTest >> test_6_GameWinner [

	| match dice |

	dice := Dice with: (self sixSidedDieFixedIn: #(6 4 2 3 3)).
	match := Match among: self fourPlayers using: dice over: (Board withTiles: 10).
		
	self
		assert: match isInProgress;
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match.
	
	[ match isInProgress ] 
		whileTrue: [ match nextTurn ].
		
	self
		deny: match isInProgress;
		assert: self fourPlayers rankAt: #(1 2 4 3) during: match;
		assert: self fourPlayers areAt: #(10 5 3 4) during: match;
		assert: match winner equals: (Player named: 'Ezequiel')
]

{ #category : #tests }
MatchTest >> test_7_AskingForWinnerWhenGameIsInProgressRaisesException [

	| match dice |

	dice := Dice with: (self sixSidedDieFixedIn: #(6 4 2 3 3)).
	match := Match among: self fourPlayers using: dice over: (Board withTiles: 10).
		
	self
		assert: match isInProgress;
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match.
		
	self
		should: [ match winner ] 
		raise: AssertionFailed
		withMessageText: 'There is no winner yet.'
]

{ #category : #tests }
MatchTest >> test_8_OvertakeAPlayer [

	| match dice |

	dice := Dice with: (self sixSidedDieFixedIn: #(6 2 4)).
	match := Match among: self fourPlayers using: dice over: self oneHundredTilesBoard.
		
	self
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match.
	
	match nextTurn.
	self
		assert: self fourPlayers rankAt: #(1 2 2 2) during: match;
		assert: self fourPlayers areAt: #(7 1 1 1) during: match.
	
	match nextTurn.
	self
		assert: self fourPlayers rankAt: #(1 2 3 3) during: match;
		assert: self fourPlayers areAt: #(7 3 1 1) during: match.
		
	match nextTurn.
	self
		assert: self fourPlayers rankAt: #(1 3 2 4) during: match;
		assert: self fourPlayers areAt: #(7 3 5 1) during: match
]

{ #category : #tests }
MatchTest >> test_9_OvertakeOnePlayerAndTieWithAnother [

	| match dice |

	dice := Dice with: (self sixSidedDieFixedIn: #(6 2 4 4)).
	match := Match among: self fourPlayers using: dice over: self oneHundredTilesBoard.
		
	self
		assert: self fourPlayers rankAt: #(1 1 1 1) during: match;
		assert: self fourPlayers areAt: #(1 1 1 1) during: match.
	
	match nextTurn.
	self
		assert: self fourPlayers rankAt: #(1 2 2 2) during: match;
		assert: self fourPlayers areAt: #(7 1 1 1) during: match.
	
	match nextTurn.
	self
		assert: self fourPlayers rankAt: #(1 2 3 3) during: match;
		assert: self fourPlayers areAt: #(7 3 1 1) during: match.
		
	match nextTurn.
	self
		assert: self fourPlayers rankAt: #(1 3 2 4) during: match;
		assert: self fourPlayers areAt: #(7 3 5 1) during: match.
		
	match nextTurn.
	self
		assert: self fourPlayers rankAt: #(1 4 2 2) during: match;
		assert: self fourPlayers areAt: #(7 3 5 5) during: match
]
