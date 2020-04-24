Class {
	#name : #ProcessorOfWatchpointAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointAdd >> initialize [ 
	self stepName: 'WatchpointAdd'.
	self kind: 'Watchpoint'.
	self origin: 'AddedDuringDebug'.
]

{ #category : #accessing }
ProcessorOfWatchpointAdd >> process: aWatchpointNode [ 

	| contextProperty breakpointData alreadyExist |
		
	contextProperty := ContextPropertyBreakpoint new extract: aWatchpointNode.
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
