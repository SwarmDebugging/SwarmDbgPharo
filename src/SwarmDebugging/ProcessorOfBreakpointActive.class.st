Class {
	#name : #ProcessorOfBreakpointActive,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointActive >> initialize [ 
	self stepName: 'BreakpointActive'.
]

{ #category : #accessing }
ProcessorOfBreakpointActive >> process: aBreakpointNode [ 

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.

	self processEvent: contextProperty.
	
	Repository save: SessionService getCurrentSession.
]
