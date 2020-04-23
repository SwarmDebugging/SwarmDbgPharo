Class {
	#name : #ProcessorOfWatchpointRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointRemove >> initialize [ 
	self stepName: 'WatchpointRemove'.
]

{ #category : #accessing }
ProcessorOfWatchpointRemove >> process: aWatchpointNode [ 

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aWatchpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.

	self processEvent: contextProperty.
	
	Repository save: SessionService getCurrentSession.
]
