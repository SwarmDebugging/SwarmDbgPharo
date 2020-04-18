Class {
	#name : #ProcessorOfBreakpointRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointRemove >> initialize [ 
	self stepName: 'BreakpointRemove'.
]

{ #category : #accessing }
ProcessorOfBreakpointRemove >> process: aBreakpointNode [ 

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.

	self processEvent: contextProperty.
	
	Repository save: SessionService getCurrentSession.
]
