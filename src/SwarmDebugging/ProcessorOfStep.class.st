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

	| event_id pathNode contextProperty |

	contextProperty := ContextProperty new extract: aContext.

	contextProperty filePath: (SessionService processCodeFile: contextProperty).
	
	contextProperty stepName: self stepName.

	event_id := SessionService processEvent: contextProperty.
	
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
		event_Id: event_id;
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

{ #category : #accessing }
ProcessorOfStep >> stepName [
	^stepName
]

{ #category : #accessing }
ProcessorOfStep >> stepName: aName [
	stepName := aName
]
