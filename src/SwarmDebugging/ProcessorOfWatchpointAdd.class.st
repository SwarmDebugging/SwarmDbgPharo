Class {
	#name : #ProcessorOfWatchpointAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointAdd >> extract: aContext [ 

	self extractForWatchpoint: aContext.
	
	super extract: aContext.
]

{ #category : #initialization }
ProcessorOfWatchpointAdd >> initialize [ 
	self stepName: 'WatchpointAdd'.
	self kind: 'Watchpoint'.
	self origin: 'AddedDuringDebug'.
]

{ #category : #process }
ProcessorOfWatchpointAdd >> process: aWatchpointNode [ 

	| breakpointData alreadyExist |
		
	super process: aWatchpointNode.
	
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
