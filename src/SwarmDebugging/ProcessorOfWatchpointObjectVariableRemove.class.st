Class {
	#name : #ProcessorOfWatchpointObjectVariableRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointObjectVariableRemove >> initialize [ 
	self stepName: 'WatchpointObjectVariableRemove'.
]
