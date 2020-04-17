Class {
	#name : #ProcessorOfBreakpoint,
	#superclass : #ProcessorOfSession,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #accessing }
ProcessorOfBreakpoint >> process: aBreakpointNode [

	| contextProperty breakpointData |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: 'BreakpointAdd'.
		
	self processCodeFile: contextProperty.
	
	breakpointData := BreakpointData new 
		id: UUID new printString;
		breakpointKind: 'Line';
		namespace: contextProperty packageName;
		type: contextProperty className;
		codeFilePath: contextProperty filePath;
		lineNumber: contextProperty lineNumber;
		lineOfCode: contextProperty lineOfCode;
		origin: 'AddedBeforeDebug';
		created: DateAndTimeSwarm now.			
			
	SessionService processEvent: contextProperty.
			
	SessionService getCurrentSession breakpoints add: breakpointData. 
			
	Repository save: SessionService getCurrentSession.
]
