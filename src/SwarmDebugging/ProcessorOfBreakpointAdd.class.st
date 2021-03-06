Class {
	#name : #ProcessorOfBreakpointAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointAdd >> initialize [ 
	self stepName: 'BreakpointAdd'.
	self kind: 'Line'.
	self origin: 'AddedDuringDebug'.
]

{ #category : #process }
ProcessorOfBreakpointAdd >> process: aBreakpointNode [ 

	| breakpointData alreadyExist |
		
	super process: aBreakpointNode.
	
	breakpointData := self processBreakpoint.

	alreadyExist := false.
	SessionService getCurrentSession breakpoints do: [
		:breakpointItem | 
			(breakpointItem codeFilePath = breakpointData codeFilePath) &
			(breakpointItem lineNumber = breakpointData lineNumber) &
			(breakpointItem lineOfCode = breakpointData lineOfCode)			
			ifTrue: [ 
				alreadyExist := true 
			] 
		].

	alreadyExist ifTrue: [ ^self. ].

	SessionService getCurrentSession addBreakpoint: breakpointData. 

	Repository save: SessionService getCurrentSession.



]
