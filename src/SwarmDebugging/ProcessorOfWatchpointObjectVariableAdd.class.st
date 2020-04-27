Class {
	#name : #ProcessorOfWatchpointObjectVariableAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointObjectVariableAdd >> initialize [ 
	self stepName: 'WatchpointObjectVariableAdd'.
]
