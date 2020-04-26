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

{ #category : #process }
ProcessorOfBreakpointAlreadyAdded >> process: aBreakpointNode [

	super process: aBreakpointNode.
			
	SessionService getCurrentSession addBreakpoint: self processBreakpoint.
			
	Repository save: SessionService getCurrentSession.
]
