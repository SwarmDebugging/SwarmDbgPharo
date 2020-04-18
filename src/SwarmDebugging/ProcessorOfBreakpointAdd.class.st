Class {
	#name : #ProcessorOfBreakpointAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointAdd >> initialize [ 
	self stepName: 'BreakpointAdd'.
	self kind: 'BreakpointAdd'.
	self origin: 'AddedDuringDebug'.
]

{ #category : #accessing }
ProcessorOfBreakpointAdd >> process: aBreakpointNode [ 

	| contextProperty breakpointData alreadyExist |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.
	
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

	alreadyExist ifFalse: [ 
			self processEvent: contextProperty.
			
			SessionService getCurrentSession breakpoints add: breakpointData. 
			
			Repository save: SessionService getCurrentSession.
		].

]
