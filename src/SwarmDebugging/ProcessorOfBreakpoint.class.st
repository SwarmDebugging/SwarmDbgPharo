Class {
	#name : #ProcessorOfBreakpoint,
	#superclass : #ProcessorOfSession,
	#instVars : [
		'kind',
		'origin'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #accessing }
ProcessorOfBreakpoint >> kind [
	^kind
]

{ #category : #accessing }
ProcessorOfBreakpoint >> kind: value [ 
	kind := value
]

{ #category : #accessing }
ProcessorOfBreakpoint >> origin [
	^origin
]

{ #category : #accessing }
ProcessorOfBreakpoint >> origin: value [ 
	origin := value
]

{ #category : #accessing }
ProcessorOfBreakpoint >> process: aBreakpointNode [ 

	| contextProperty |
		
	contextProperty := ContextPropertyBreakpoint new extract: aBreakpointNode.
	contextProperty stepName: self stepName.
		
	self processCodeFile: contextProperty.

	self processEvent: contextProperty.
	
	Repository save: SessionService getCurrentSession.
	
	^contextProperty.
]

{ #category : #process }
ProcessorOfBreakpoint >> processBreakpoint: aContextProperty [ 

	^BreakpointData new 
		id: UUID new printString;
		breakpointKind: self kind;
		namespace: aContextProperty packageName;
		type: aContextProperty className;
		codeFilePath: aContextProperty filePath;
		lineNumber: aContextProperty lineNumber;
		lineOfCode: aContextProperty lineOfCode;
		origin: self origin;
		created: DateAndTimeSwarm now.	

]
