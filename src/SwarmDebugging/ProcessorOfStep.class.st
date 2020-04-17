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
