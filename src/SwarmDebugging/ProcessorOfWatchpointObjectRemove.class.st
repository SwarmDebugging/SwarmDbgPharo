Class {
	#name : #ProcessorOfWatchpointObjectRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointObjectRemove >> extract: aContext [ 

	self extractForWatchpoint: aContext.
	
	super extract: aContext.
]

{ #category : #initialization }
ProcessorOfWatchpointObjectRemove >> initialize [ 
	self stepName: 'WatchpointObjectRemove'.
]

{ #category : #process }
ProcessorOfWatchpointObjectRemove >> process: aWatchpointNode instanceObject: instanceObject [
	
	self objectId: instanceObject identityHash.
	
	self process: aWatchpointNode.
]
