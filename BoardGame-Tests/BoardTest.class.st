Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Tests'
}

{ #category : #tests }
BoardTest >> testBoardCreation [

	| tilesAmount board |
	
	tilesAmount := 50.
	board := Board withTiles: tilesAmount.
	self assert: board tilesAmount equals: tilesAmount
]

{ #category : #tests }
BoardTest >> testPrintOn [

	| tilesAmount board |
	
	tilesAmount := 50.
	board := Board withTiles: tilesAmount.
	self 
		assert: board printString 
		equals: ('Board with <1p> tiles' expandMacrosWith: tilesAmount)
]
