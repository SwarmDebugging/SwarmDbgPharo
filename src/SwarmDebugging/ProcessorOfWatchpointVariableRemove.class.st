Class {
	#name : #ProcessorOfWatchpointVariableRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointVariableRemove >> initialize [ 
	self stepName: 'WatchpointVariableRemove'.
]
