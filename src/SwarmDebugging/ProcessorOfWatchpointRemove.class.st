Class {
	#name : #ProcessorOfWatchpointRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointRemove >> extract: aContext [ 

	self extractForWatchpoint: aContext.
	
	super extract: aContext.
]

{ #category : #initialization }
ProcessorOfWatchpointRemove >> initialize [ 
	self stepName: 'WatchpointRemove'.
]
