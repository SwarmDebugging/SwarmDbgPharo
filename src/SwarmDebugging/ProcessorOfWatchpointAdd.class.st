Class {
	#name : #ProcessorOfWatchpointAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointAdd >> extract: aContext [ 

	self variableName: (aContext variable ifNil: [ aContext name ] ifNotNil: [ aContext variable name ] ).
	self variableValue: (aContext value ifNotNil: [ aContext value name ]).

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
		
	self extract: aWatchpointNode.
		
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
