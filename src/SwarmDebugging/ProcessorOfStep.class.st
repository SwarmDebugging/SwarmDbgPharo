Class {
	#name : #ProcessorOfStep,
	#superclass : #ProcessorOfSession,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfStep >> process: aContext [

	| contextProperty |

	contextProperty := ContextPropertyStep new extract: aContext.
	contextProperty stepName: self stepName.

	self processCodeFile: contextProperty.
	
	self processEvent: contextProperty.
	
	self processPathNode: contextProperty.
	
	Repository save: SessionService getCurrentSession.
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

{ #category : #'as yet unclassified' }
ProcessorOfStep >> processPathNode: aContextProperty [ 

	| pathNode |

	pathNode := PathNode new 
		id: UUID new printString;
		hash: '';
		namespace: aContextProperty packageName;
		type: aContextProperty className;
		method: aContextProperty methodName;
		parent: nil;
		parent_Id: (SessionService getCurrentSession pathNodes isEmpty 
			ifTrue: [ '00000000-0000-0000-0000-000000000000' ] 
			ifFalse: [ SessionService getCurrentSession pathNodes last id ]);
		origin: aContextProperty stepName;
		returnType: 'void';
		parameters: OrderedCollection new;
		event_Id: aContextProperty event_id;
		created: DateAndTimeSwarm now.
		
	SessionService getCurrentSession pathNodes add: pathNode.	

]
