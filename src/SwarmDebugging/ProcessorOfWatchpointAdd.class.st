Class {
	#name : #ProcessorOfWatchpointAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointAdd >> extract: aContext [ 

	| variableExist valueExist |
	
	variableExist := false.
	valueExist := false.
	
	aContext class allInstVarNames do: [ :item | (item = #variable) ifTrue: [ variableExist := true. ] ].
	aContext class allInstVarNames do: [ :item | (item = #value) ifTrue: [ valueExist := true. ] ].

	self variableName: (variableExist ifFalse: [ aContext name ] ifTrue: [ aContext variable name ] ).
	self variableValue: (valueExist ifTrue: [ aContext value name ]).
	
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
