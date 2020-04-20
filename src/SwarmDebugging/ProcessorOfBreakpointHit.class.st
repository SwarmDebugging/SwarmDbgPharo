Class {
	#name : #ProcessorOfBreakpointHit,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointHit >> initialize [ 
	self stepName: 'BreakpointHitted'.
]

{ #category : #accessing }
ProcessorOfBreakpointHit >> process: aBreakpointNode [ 

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.

	self processEvent: contextProperty.
	
	Repository save: SessionService getCurrentSession.
]
