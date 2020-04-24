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
		
	contextProperty := ContextPropertyBreakpoint new extract: aWatchpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.
			
	SessionService getCurrentSession addBreakpoint: (self processBreakpoint: contextProperty). 			
			
	self processEvent: contextProperty.
			
	Repository save: SessionService getCurrentSession.
]
