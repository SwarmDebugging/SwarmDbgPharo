Class {
	#name : #ProcessorOfWatchpointObjectAlreadyAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointObjectAlreadyAdd >> extract: aContext [ 

	self extractForWatchpoint: aContext.
	
	super extract: aContext.
]

{ #category : #initialization }
ProcessorOfWatchpointObjectAlreadyAdd >> initialize [ 
	self stepName: 'WatchpointObjectAdd'.
	self kind: 'WatchpointObject'.
	self origin: 'AddedBeforeDebug'.
]

{ #category : #process }
ProcessorOfWatchpointObjectAlreadyAdd >> process: aWatchpointNode instanceObject: instanceObject [

	| breakpointData |
	
	self objectId: instanceObject identityHash.
	
	self process: aWatchpointNode.
	
	breakpointData := self processBreakpoint.
	
	breakpointData objectId: self objectId.
			
	SessionService getCurrentSession addBreakpoint: breakpointData. 
			
	Repository save: SessionService getCurrentSession.

]
