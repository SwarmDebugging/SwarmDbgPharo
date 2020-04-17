Class {
	#name : #ProcessorOfBreakpoint,
	#superclass : #ProcessorOfSession,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #accessing }
ProcessorOfBreakpoint >> process: aBreakpointNode [

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: 'BreakpointAdd'.
		
	self processCodeFile: contextProperty.
	
	self processBreakpoint: contextProperty.		
			
	self processEvent: contextProperty.
			
	Repository save: SessionService getCurrentSession.
]

{ #category : #'as yet unclassified' }
ProcessorOfBreakpoint >> processBreakpoint: aContextProperty [ 

	| breakpointData |

	breakpointData := BreakpointData new 
		id: UUID new printString;
		breakpointKind: 'Line';
		namespace: aContextProperty packageName;
		type: aContextProperty className;
		codeFilePath: aContextProperty filePath;
		lineNumber: aContextProperty lineNumber;
		lineOfCode: aContextProperty lineOfCode;
		origin: 'AddedBeforeDebug';
		created: DateAndTimeSwarm now.	
		
	SessionService getCurrentSession breakpoints add: breakpointData. 
]
