Class {
	#name : #ProcessorOfStep,
	#superclass : #ProcessorOfSession,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfStep >> extract: aContext [
	
	| typeWord namespaceWord lineOfCodeNode |
	
	typeWord := aContext methodClass asString.
	((typeWord indexOfSubCollection: ' class') asNumber > 1) ifTrue: [
			typeWord := typeWord copyFrom: 1 to: (typeWord indexOfSubCollection: ' class') - 1
		].

	lineOfCodeNode := (aContext method sourceNodeForPC: aContext pc).

	[ namespaceWord := (Smalltalk at: typeWord asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].
	
	self packageName: namespaceWord.
	self className: typeWord.
	self methodName: aContext methodSelector asString.
	self sourceCode: (aContext sourceCode asString) contents.
	self charStart: lineOfCodeNode start.
	self charEnd: lineOfCodeNode stop.	
	self lineOfCode: ( lineOfCodeNode source copyFrom: self charStart to: self charEnd ) asString.
	self lineNumber: (lineOfCodeNode source copyFrom: 1 to: self charStart ) asString lineCount.

		
]

{ #category : #process }
ProcessorOfStep >> process: aContext [

	self extract: aContext.

	self processCodeFile.
	
	self processEvent.
	
	self processPathNode.
	
	Repository save: SessionService getCurrentSession.
]

{ #category : #process }
ProcessorOfStep >> processPathNode [ 

	| pathNode |

	pathNode := PathNode new 
		id: UUID new printString;
		hash: '';
		namespace: self packageName;
		type: self className;
		method: self methodName;
		parent: nil;
		parent_Id: (SessionService getCurrentSession pathNodes isEmpty 
			ifTrue: [ '00000000-0000-0000-0000-000000000000' ] 
			ifFalse: [ SessionService getCurrentSession pathNodes last id ]);
		origin: self stepName;
		returnType: 'void';
		parameters: OrderedCollection new;
		event_Id: self event_id;
		created: DateAndTimeSwarm now.
		
	SessionService getCurrentSession addPathNode: pathNode.	


]
