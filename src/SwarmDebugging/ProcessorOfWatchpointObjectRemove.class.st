Class {
	#name : #ProcessorOfWatchpointObjectRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointObjectRemove >> initialize [ 
	self stepName: 'WatchpointObjectRemove'.
]

{ #category : #process }
ProcessorOfWatchpointObjectRemove >> process: aWatchpointNode instanceObject: instanceObject [
	
	self objectId: instanceObject identityHash.
	
	self extract: aWatchpointNode.
		
	self processCodeFile.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
]
