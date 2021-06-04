Class {
	#name : #BaselineOfBoardGame,
	#superclass : #BaselineOf,
	#category : #BaselineOfBoardGame
}

{ #category : #accessing }
BaselineOfBoardGame >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ 
			self setUpDependencies: spec.
			spec
				package: 'BoardGame-Model' with: [ spec requires: 'Buoy' ];
				package: 'BoardGame-Tests' with: [ spec requires: 'BoardGame-Model' ]]
]

{ #category : #accessing }
BaselineOfBoardGame >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfBoardGame >> setUpDependencies: spec [

	spec
		baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v6/source' ];
		project: 'Buoy-Deployment' copyFrom: 'Buoy' with: [ spec loads: 'Deployment' ];
		project: 'Buoy-SUnit' copyFrom: 'Buoy' with: [ spec loads: 'Dependent-SUnit-Extensions' ];
		project: 'Buoy-Tools' copyFrom: 'Buoy' with: [ spec loads: 'Tools' ]
]
