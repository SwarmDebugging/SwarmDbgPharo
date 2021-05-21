Class {
	#name : #BaselineOfSwarmDebugging,
	#superclass : #BaselineOf,
	#category : #BaselineOfSwarmDebugging
}

{ #category : #baselines }
BaselineOfSwarmDebugging >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec package: 'SwarmDebugging'.
		spec
			baseline: 'NeoJSON'
			with: [ spec repository: 'github://svenvc/NeoJSON/repository' ] ]
]

{ #category : #accessing }
BaselineOfSwarmDebugging >> postload: loader package: packageSpec [

	OupsDebuggerSelectionStrategy debuggerSelectionStrategy:
		SwarmSingleDebuggerSelector
]

{ #category : #baselines }
BaselineOfSwarmDebugging >> projectClass [
	^ MetacelloCypressBaselineProject
]
