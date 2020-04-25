Class {
	#name : #ProcessorOfWatchpointRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointRemove >> initialize [ 
	self stepName: 'WatchpointRemove'.
]
