Class {
	#name : #ProcessorOfStep,
	#superclass : #Object,
	#instVars : [
		'stepName'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #accessing }
ProcessorOfStep >> process: aContext [

	| event_id pathNode contextProperty |

	contextProperty	:= SessionService processStepContext: aContext.

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
		origin: stepName;
		returnType: 'void';
		parameters: OrderedCollection new;
		event_Id: event_id;
		created: DateAndTimeSwarm now.
		
	SessionService getCurrentSession pathNodes add: pathNode.	
	
	Repository save: SessionService getCurrentSession.
]

{ #category : #accessing }
ProcessorOfStep >> stepName [
	^stepName
]

{ #category : #accessing }
ProcessorOfStep >> stepName: aName [
	stepName := aName
]
