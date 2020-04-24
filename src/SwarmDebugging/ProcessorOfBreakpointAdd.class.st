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

{ #category : #accessing }
ProcessorOfBreakpointAdd >> process: aBreakpointNode [ 

	| contextProperty breakpointData alreadyExist |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.

	self processCodeFile: contextProperty.
	
	self processEvent: contextProperty.

	Repository save: SessionService getCurrentSession.	
	
	breakpointData := self processBreakpoint: contextProperty.

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
