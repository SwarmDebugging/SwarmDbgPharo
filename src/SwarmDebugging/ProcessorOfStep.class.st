Class {
	#name : #ProcessorOfStep,
	#superclass : #Object,
	#instVars : [
		'stepName'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfStep >> process: aContext [

	| pathNode contextProperty |

	contextProperty := ContextProperty new extract: aContext.
	contextProperty stepName: self stepName.

	self processCodeFile: contextProperty.
	
	self processEvent: contextProperty.
	
	"PathNode"
	pathNode := PathNode new 
		id: UUID new printString;
		hash: '';
		namespace: contextProperty packageName;
		type: contextProperty className;
		method: contextProperty methodName;
		parent: nil;
		parent_Id: (SessionService getCurrentSession pathNodes isEmpty 
			ifTrue: [ '00000000-0000-0000-0000-000000000000' ] 
			ifFalse: [ SessionService getCurrentSession pathNodes last id ]);
		origin: self stepName;
		returnType: 'void';
		parameters: OrderedCollection new;
		event_Id: contextProperty event_id;
		created: DateAndTimeSwarm now.
		
	SessionService getCurrentSession pathNodes add: pathNode.	
	
	Repository save: SessionService getCurrentSession.
]

{ #category : #process }
ProcessorOfStep >> processCodeFile: aContextProperty [

	| codeFile alreadyExist |

	aContextProperty codeFilePath: (FileLocator imageDirectory / aContextProperty packageName / aContextProperty className, 'st') pathString.	

	codeFile := CodeFile new 
		id: UUID new printString;
		path: aContextProperty codeFilePath;
		content: (ZnBase64Encoder new encode: (aContextProperty sourceCode) asByteArray);
		created: DateAndTimeSwarm now.
	
	alreadyExist := false.
	SessionService getCurrentSession codeFiles do: [ 
		:file | file path = (aContextProperty codeFilePath) ifTrue: [ 
			alreadyExist := true 
			] 
		].
	
	alreadyExist ifFalse: [ 
			SessionService getCurrentSession codeFiles add: codeFile. 
		 ].
]

{ #category : #process }
ProcessorOfStep >> processEvent: aContextProperty [

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
		
	SessionService getCurrentSession events add: event.
	
]

{ #category : #accessing }
ProcessorOfStep >> stepName [
	^stepName
]

{ #category : #accessing }
ProcessorOfStep >> stepName: aName [
	stepName := aName
]
