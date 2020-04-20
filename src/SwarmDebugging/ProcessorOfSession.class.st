Class {
	#name : #ProcessorOfSession,
	#superclass : #Object,
	#instVars : [
		'stepName'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfSession >> processCodeFile: aContextProperty [

	| codeFile alreadyExist |

	aContextProperty filePath: (FileLocator imageDirectory / aContextProperty packageName / aContextProperty className, 'st') pathString.	

	codeFile := CodeFile new 
		id: UUID new printString;
		path: aContextProperty filePath;
		content: (ZnBase64Encoder new encode: (aContextProperty sourceCode) asByteArray);
		created: DateAndTimeSwarm now.
	
	alreadyExist := false.
	SessionService getCurrentSession codeFiles do: [ 
		:file | file path = (aContextProperty filePath) ifTrue: [ 
			alreadyExist := true 
			] 
		].
	
	alreadyExist ifTrue: [ ^self ].

	SessionService getCurrentSession addCodeFile: codeFile. 
	
]

{ #category : #process }
ProcessorOfSession >> processEvent: aContextProperty [

	| event |

	aContextProperty event_id: UUID new printString.

	event := Event new
		id: aContextProperty event_id; 
		eventKind: aContextProperty stepName;
		detail: 'TODO';
		namespace: aContextProperty packageName;
		type: aContextProperty className;
		typeFullPath: 'TODO';
		method: aContextProperty methodName;
		methodKey: '';
		methodSignature: '';
		charStart: aContextProperty charStart;
		charEnd: aContextProperty charEnd;
		codeFilePath: aContextProperty filePath;
		lineNumber: aContextProperty lineNumber;
		lineOfCode: aContextProperty lineOfCode;
		created: DateAndTimeSwarm now.
		
	SessionService getCurrentSession addEvent: event.
	
	^self.
	
]

{ #category : #accessing }
ProcessorOfSession >> stepName [
	^stepName
]

{ #category : #accessing }
ProcessorOfSession >> stepName: aName [
	stepName := aName
]
