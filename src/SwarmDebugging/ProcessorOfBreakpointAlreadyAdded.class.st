Class {
	#name : #ProcessorOfBreakpointAlreadyAdded,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointAlreadyAdded >> initialize [ 
	self stepName: 'BreakpointAdd'.
	self kind: 'Line'.
	self origin: 'AddedBeforeDebug'.
]

{ #category : #accessing }
ProcessorOfBreakpointAlreadyAdded >> process: aBreakpointNode [

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.
			
	SessionService getCurrentSession breakpoints add: (self processBreakpoint: contextProperty). 			
			
	self processEvent: contextProperty.
			
	Repository save: SessionService getCurrentSession.
]
