Class {
	#name : #ProcessorOfWatchpointAlreadyAdded,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointAlreadyAdded >> initialize [ 
	self stepName: 'WatchpointAdd'.
	self kind: 'Watchpoint'.
	self origin: 'AddedBeforeDebug'.
]

{ #category : #accessing }
ProcessorOfWatchpointAlreadyAdded >> process: aWatchpointNode [

	| contextProperty |
		
	contextProperty := super process: aWatchpointNode.

	SessionService getCurrentSession addBreakpoint: (self processBreakpoint: contextProperty). 			
			
	Repository save: SessionService getCurrentSession.
]
