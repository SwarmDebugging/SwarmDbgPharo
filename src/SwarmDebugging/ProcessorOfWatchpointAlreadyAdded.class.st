Class {
	#name : #ProcessorOfWatchpointAlreadyAdded,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointAlreadyAdded >> extract: aContext [ 

	self extractForWatchpoint: aContext.
	
	super extract: aContext.
]

{ #category : #initialization }
ProcessorOfWatchpointAlreadyAdded >> initialize [ 
	self stepName: 'WatchpointAdd'.
	self kind: 'Watchpoint'.
	self origin: 'AddedBeforeDebug'.
]

{ #category : #accessing }
ProcessorOfWatchpointAlreadyAdded >> process: aWatchpointNode [
	
	super process: aWatchpointNode.

	SessionService getCurrentSession addBreakpoint: self processBreakpoint.
			
	Repository save: SessionService getCurrentSession.
]
