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
	
	contextProperty := super process: aBreakpointNode.
			
	SessionService getCurrentSession addBreakpoint: (self processBreakpoint: contextProperty). 			
			
	Repository save: SessionService getCurrentSession.
]
