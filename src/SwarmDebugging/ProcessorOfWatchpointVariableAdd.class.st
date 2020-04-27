Class {
	#name : #ProcessorOfWatchpointVariableAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointVariableAdd >> initialize [ 
	self stepName: 'WatchpointVariableAdd'.
]
