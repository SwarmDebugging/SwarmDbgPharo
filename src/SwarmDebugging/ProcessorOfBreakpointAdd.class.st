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

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.
	
"	self processBreakpoint: contextProperty.		
			
	self processEvent: contextProperty.
			
	Repository save: SessionService getCurrentSession."
	
	"-------------------------"
	
"	alreadyExist := false.
	currentSession breakpoints do: [
		:breakpointItem | 
			(breakpointItem codeFilePath = breakpointData codeFilePath) &
			(breakpointItem lineNumber = breakpointData lineNumber)
			ifTrue: [ 
				alreadyExist := true 
			] 
		].
	
	alreadyExist ifFalse: [ 
			self processEvent: contextProperty.
			currentSession breakpoints add: breakpointData. 
			
			Repository save: currentSession.
		 ]."
]
