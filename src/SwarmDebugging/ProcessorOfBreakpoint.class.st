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

{ #category : #'as yet unclassified' }
ProcessorOfBreakpoint >> processBreakpoint: aContextProperty [ 

	| breakpointData |

	breakpointData := BreakpointData new 
		id: UUID new printString;
		breakpointKind: self kind;
		namespace: aContextProperty packageName;
		type: aContextProperty className;
		codeFilePath: aContextProperty filePath;
		lineNumber: aContextProperty lineNumber;
		lineOfCode: aContextProperty lineOfCode;
		origin: self origin;
		created: DateAndTimeSwarm now.	
		
	SessionService getCurrentSession breakpoints add: breakpointData. 
]
