Class {
	#name : #ProcessorOfBreakpoint,
	#superclass : #ProcessorOfSession,
	#instVars : [
		'kind',
		'origin'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfBreakpoint >> extract: aContext [

	| namespaceWord |

	self className: aContext methodNode methodClass asString.
	self methodName: aContext methodNode selector asString.

	[ namespaceWord := (Smalltalk at: self className asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].

	self packageName: namespaceWord.
	self sourceCode: (aContext methodNode sourceCode asString) contents.
	self charStart: aContext start.
	self charEnd: aContext stop.
	self lineOfCode: (aContext methodNode source copyFrom: self charStart to: self charEnd) asString.
	self lineNumber: (aContext methodNode source copyFrom: 1 to: self charStart) asString lineCount.
	
]

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

{ #category : #process }
ProcessorOfBreakpoint >> process: aBreakpointNode [ 
	
	self extract: aBreakpointNode.
		
	self processCodeFile.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
]

{ #category : #process }
ProcessorOfBreakpoint >> processBreakpoint [ 

	^BreakpointData new 
		id: UUID new printString;
		breakpointKind: self kind;
		namespace: self packageName;
		type: self className;
		codeFilePath: self filePath;
		lineNumber: self lineNumber;
		lineOfCode: self lineOfCode;
		origin: self origin;
		created: DateAndTimeSwarm now.	

]
