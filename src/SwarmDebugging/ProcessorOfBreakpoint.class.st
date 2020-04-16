Class {
	#name : #ProcessorOfBreakpoint,
	#superclass : #Object,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #accessing }
ProcessorOfBreakpoint >> process: aBreakpointNode [

	| contextProperty breakpointData sourceCodeStream lineOfCode lineNumber lineStart lineStop |
		
	sourceCodeStream := aBreakpointNode methodNode sourceCode asString.
			
	lineStart := aBreakpointNode start.
	lineStop := aBreakpointNode stop.

	lineOfCode := (aBreakpointNode methodNode source copyFrom: lineStart to: lineStop) asString.

	lineNumber := (aBreakpointNode methodNode source copyFrom: 1 to: lineStart) asString lineCount.

	contextProperty := ContextProperty getInstance
		stepName: 'BreakpointAdd';
		methodName: aBreakpointNode methodNode selector asString;
		className: aBreakpointNode methodNode methodClass asString;
		packageName: (SessionService getNamespace: aBreakpointNode methodNode methodClass asString);
		sourceCode: sourceCodeStream contents; 
		lineOfCode: lineOfCode;
		lineNumber: lineNumber;
		charStart: lineStart;
		charEnd: lineStop.
		
	contextProperty filePath: (SessionService processCodeFile: contextProperty).
	
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
