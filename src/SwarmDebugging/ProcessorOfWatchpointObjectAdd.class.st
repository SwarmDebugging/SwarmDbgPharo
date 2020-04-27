Class {
	#name : #ProcessorOfWatchpointObjectAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

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
