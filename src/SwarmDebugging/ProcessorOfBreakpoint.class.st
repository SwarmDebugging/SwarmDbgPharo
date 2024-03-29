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

{ #category : #'as yet unclassified' }
ProcessorOfBreakpoint >> extract: aVariable class: aClass [

	| namespaceWord classOrMethod methodIndex classPart methodPart |

	classPart := aClass name asString.
	methodPart := nil.

	classOrMethod := aClass name asString.
	methodIndex := classOrMethod indexOfSubCollection: '>>'.

	(methodIndex > 0) ifTrue: [ 
			classPart := classOrMethod copyFrom: 1 to: methodIndex - 1.
			methodPart := classOrMethod copyFrom: (methodIndex + 3) to: classOrMethod size.		
		 ].

	self className: classPart.
	self methodName: methodPart.

	[ namespaceWord := (Smalltalk at: self className asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].

	self packageName: namespaceWord.
	self sourceCode: nil.
	self charStart: nil.
	self charEnd: nil.
	self lineOfCode: nil.
	self lineNumber: nil.
	
	self variableName: aVariable asString.
	
]

{ #category : #'as yet unclassified' }
ProcessorOfBreakpoint >> extract: aVariable instance: aObject [

	| namespaceWord |

	self className: aObject class name.
	self methodName: nil.

	[ namespaceWord := (Smalltalk at: self className asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].

	self packageName: namespaceWord.
	self sourceCode: nil.
	self charStart: nil.
	self charEnd: nil.
	self lineOfCode: nil.
	self lineNumber: nil.
	self objectId: aObject identityHash asString.
	
	self variableName: aVariable asString.
	
]

{ #category : #process }
ProcessorOfBreakpoint >> extractForWatchpoint: aContext [

	| variableExist valueExist valueNameExist |
	variableExist := false.
	valueExist := false.
	valueNameExist := false.

	aContext class allInstVarNames do: [ :item | 
		item = #variable ifTrue: [ variableExist := true ] ].
	aContext class allInstVarNames do: [ :item | 
		item = #value ifTrue: [ valueExist := true ] ].

	valueExist ifTrue: [ 
		aContext value class allInstVarNames do: [ :item | 
			item = #name ifTrue: [ valueNameExist := true ] ] ].

	self variableName: (variableExist
			 ifFalse: [ aContext name ]
			 ifTrue: [ aContext variable name ]).
	self variableValue: (valueExist ifTrue: [ 
			 valueNameExist
				 ifTrue: [ aContext value name ]
				 ifFalse: [ 
					 aContext value value ifNotNil: [ :n | 
						 n isString
							 ifTrue: [ n ]
							 ifFalse: [ 
								 (n isKindOf: RBNode)
									 ifTrue: [ n sourceCode ]
									 ifFalse: [ n printString ] ] ] ] ])
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

{ #category : #'as yet unclassified' }
ProcessorOfBreakpoint >> process: aVariable class: aClass [
 
	self extract: aVariable class: aClass.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
]

{ #category : #'as yet unclassified' }
ProcessorOfBreakpoint >> process: aVariable instance: aObject [
 
	self extract: aVariable instance: aObject.

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
