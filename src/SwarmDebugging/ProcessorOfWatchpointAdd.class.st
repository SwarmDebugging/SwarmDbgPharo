Class {
	#name : #ProcessorOfWatchpointAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointAdd >> initialize [ 
	self stepName: 'WatchpointAdd'.
	self kind: 'WatchpointAdd'.
	self origin: 'AddedDuringDebug'.
]

{ #category : #accessing }
ProcessorOfWatchpointAdd >> process: aWatchpointNode [ 

	| contextProperty breakpointData alreadyExist |
		
	contextProperty := ContextPropertyBreakpoint new extract: aWatchpointNode.
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

	alreadyExist ifTrue: [ ^self. ].
		 
	self processEvent: contextProperty.
			
	SessionService getCurrentSession addBreakpoint: breakpointData. 
			
	Repository save: SessionService getCurrentSession.



]
