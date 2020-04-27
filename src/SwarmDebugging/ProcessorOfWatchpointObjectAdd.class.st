Class {
	#name : #ProcessorOfWatchpointObjectAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointObjectAdd >> extract: aContext [ 

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
ProcessorOfWatchpointObjectAdd >> initialize [ 
	self stepName: 'WatchpointObjectAdd'.
	self kind: 'WatchpointObject'.
	self origin: 'AddedDuringDebug'.
]

{ #category : #process }
ProcessorOfWatchpointObjectAdd >> process: aWatchpointNode instanceObject: instanceObject [

	| breakpointData alreadyExist |
	
	self objectId: instanceObject identityHash.
	
	self extract: aWatchpointNode.
		
	self processCodeFile.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
	
	breakpointData := self processBreakpoint.
	
	breakpointData objectId: self objectId.
		
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
