Class {
	#name : #BaselineOfSwarmDebugging,
	#superclass : #BaselineOf,
	#category : #BaselineOfSwarmDebugging
}

{ #category : #baselines }
BaselineOfSwarmDebugging >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec
    			baseline: 'Sindarin'
    			with: [ spec repository: 'github://dupriezt/ScriptableDebugger' ].			
			spec
				package: 'SwarmDebugging'.
			spec
    			baseline: 'NeoJSON'
    			with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].	 
			spec
    			baseline: 'TaskIt'
    			with: [ spec repository: 'github://sbragagnolo/taskit' ].
		].
]

{ #category : #baselines }
BaselineOfSwarmDebugging >> projectClass [
	^ MetacelloCypressBaselineProject
]
