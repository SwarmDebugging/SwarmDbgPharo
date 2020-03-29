Class {
	#name : #SessionService,
	#superclass : #Object,
	#classInstVars : [
		'currentSession',
		'swarmWindowData'
	],
	#category : #'SwarmDebugging-Service'
}

{ #category : #public }
SessionService class >> endCurrentSession [ 

	currentSession ifNil: [ ^self ].

	currentSession finished: DateAndTime now.

	Repository save: currentSession.
	
	self reset.
	
]

{ #category : #internal }
SessionService class >> getNamespace: typeWord [

	|namespaceWord stringContext| 
	
	typeWord 
		ifNil: [ stringContext := 'NamespaceNotFound' ]
		ifNotNil: [ stringContext := typeWord ].

	[ namespaceWord := (Smalltalk at: stringContext asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].
	
	^namespaceWord 
]

{ #category : #public }
SessionService class >> getSwarmWindowData [
	^swarmWindowData
]

{ #category : #processAndSend }
SessionService class >> processCodeFile: contextProperty [

	| codeFile codeFilePath alreadyExist |

	currentSession ifNil: [ ^self ].

	codeFilePath := (FileLocator imageDirectory / contextProperty packageName / contextProperty className, 'st') pathString.	

	"CodeFile"
	codeFile := CodeFile new 
		id: UUID new printString;
		path: codeFilePath;
		content: (ZnBase64Encoder new encode: (contextProperty sourceCode) asByteArray);
		created: DateAndTime now.
	
	alreadyExist := false.
	currentSession codeFiles do: [ 
		:file | file path = codeFilePath ifTrue: [ 
			alreadyExist := true 
			] 
		].
	
	alreadyExist ifFalse: [ 
			currentSession codeFiles add: codeFile. 
			Repository save: currentSession.		
		 ].
	
	^codeFilePath
	

]

{ #category : #public }
SessionService class >> processEvent: contextProperty [

	| event event_id |

	currentSession ifNil: [ ^self ].

	event_id := UUID new printString.

	"Event"
	event := Event new
		id: event_id; 
		eventKind: contextProperty stepName;
		detail: 'TODO';
		namespace: contextProperty packageName;
		type: contextProperty className;
		typeFullPath: 'TODO';
		method: contextProperty methodName;
		methodKey: '';
		methodSignature: '';
		charStart: contextProperty charStart;
		charEnd: contextProperty charEnd;
		codeFilePath: contextProperty filePath;
		lineNumber: contextProperty lineNumber;
		lineOfCode: contextProperty lineOfCode;
		created: DateAndTime now.
	currentSession events add: event.
	
	Repository save: currentSession.
	
	^event_id.
	

]

{ #category : #public }
SessionService class >> processStep: context stepName: stepName [

	| event_id pathNode contextProperty |

	currentSession ifNil: [ ^self ].

	contextProperty	:= self processStepContext: context.

	contextProperty filePath: (self processCodeFile: contextProperty).
	
	contextProperty stepName: stepName.

	event_id := self processEvent: contextProperty.
	
	"PathNode"
	pathNode := PathNode new 
		id: UUID new printString;
		hash: '';
		namespace: contextProperty packageName;
		type: contextProperty className;
		method: contextProperty methodName;
		parent: nil;
		parent_Id: (currentSession pathNodes isEmpty 
			ifTrue: [ '00000000-0000-0000-0000-000000000000' ] 
			ifFalse: [ currentSession pathNodes last id ]);
		origin: stepName;
		returnType: 'void';
		parameters: OrderedCollection new;
		event_Id: event_id;
		created: DateAndTime now.
	currentSession pathNodes add: pathNode.	
	
	
	Repository save: currentSession.
	

]

{ #category : #public }
SessionService class >> processStepContext: context [

	| typeWord sourceCodeStream lineOfCode lineCounter lineNumber lineStart lineStop |
	
	typeWord := context methodClass asString.
	((typeWord indexOfSubCollection: ' class') asNumber > 1) ifTrue: [
			typeWord := typeWord copyFrom: 1 to: (typeWord indexOfSubCollection: ' class') - 1
		].
	
	sourceCodeStream := (String new: 1000) writeStream.
	context methodSelector asString = 'DoIt' 
		ifTrue: [ sourceCodeStream := context sourceCode asString. ]
		ifFalse: [ 
			(Smalltalk at: typeWord asSymbol) fileOutOn: sourceCodeStream. 
			"UndefinedObject on transcript is because fileOutOn: - review later."
		].

	lineOfCode := (context method sourceNodeForPC: context pc).
	lineStart := lineOfCode start.
	lineStop := lineOfCode stop.	
	lineOfCode := ( lineOfCode source copyFrom: lineStart to: lineStop ) asString.
	
	lineNumber := 0.
	lineCounter := 0.
	sourceCodeStream contents lines do: [ 
		:line |
			lineCounter := lineCounter + 1. 
			(line indexOfSubCollection: lineOfCode) > 0 ifTrue: [ 
				lineNumber := lineCounter.
			] 
		].	

	^ContextProperty getInstance
		methodName: context methodSelector asString;
		className: typeWord;
		packageName: (self getNamespace: typeWord);
		sourceCode: sourceCodeStream contents;
		lineOfCode: lineOfCode;
		lineNumber: lineNumber;
		charStart: lineStart;
		charEnd: lineStop.
		
	
]

{ #category : #public }
SessionService class >> registerAlreadyAddedBreakpoints [

	currentSession ifNil: [ ^self ].
	
	Breakpoint all do: [
		:breakpointItem | 
		
		| contextProperty breakpointData sourceCodeStream lineOfCode lineCounter lineNumber |
		
		sourceCodeStream := (String new: 1000) writeStream.
		(Smalltalk at: breakpointItem node methodNode methodClass asString asSymbol) fileOutOn: sourceCodeStream.
	
		lineOfCode := breakpointItem node methodNode source copyFrom: breakpointItem node start to: breakpointItem node stop.
		breakpointItem node class asString = 'RBMethodNode' 
			ifTrue: [ lineOfCode := breakpointItem node methodNode selector asString ].
		
		lineCounter := 0.
		sourceCodeStream contents lines do: [ 
			:line |
				lineCounter := lineCounter + 1. 
				(line indexOfSubCollection: lineOfCode) > 0 ifTrue: [ 
					lineNumber := lineCounter.
				] 
			].
		
		contextProperty := ContextProperty getInstance
			stepName: 'BreakpointAdd';
			methodName: breakpointItem node methodNode selector asString;
			className: breakpointItem node methodNode methodClass asString;
			packageName: (self getNamespace: breakpointItem node methodNode methodClass asString);
			sourceCode: sourceCodeStream contents; 
			lineOfCode: lineOfCode;
			lineNumber: lineNumber;
			charStart: breakpointItem node start;
			charEnd: breakpointItem node stop.
		
		contextProperty filePath: (self processCodeFile: contextProperty).
		
		breakpointData := BreakpointData new 
			id: UUID new printString;
			breakpointKind: 'Line';
			namespace: contextProperty packageName;
			type: contextProperty className;
			codeFilePath: contextProperty filePath;
			lineNumber: contextProperty lineNumber;
			lineOfCode: contextProperty lineOfCode;
			origin: 'AddedBeforeDebug';
			created: DateAndTime now.			
			
		self processEvent: contextProperty.
			
		currentSession breakpoints add: breakpointData. 
			
		Repository save: currentSession.
	].

]

{ #category : #public }
SessionService class >> registerBreakpoint: nodeContext [

	| contextProperty lineCounter lineOfCode lineNumber sourceCodeStream breakpointData alreadyExist |

	currentSession ifNil: [ ^self ].

	nodeContext isNil ifTrue: [ ^self ].

	Transcript show: 'entrou no metodo'; cr.
		
	sourceCodeStream := (String new: 1000) writeStream.
	(Smalltalk at: nodeContext methodNode methodClass asString asSymbol) fileOutOn: sourceCodeStream.
	
	lineOfCode := nodeContext methodNode source copyFrom: nodeContext start to: nodeContext stop.
	nodeContext class asString = 'RBMethodNode' 
	ifTrue: [ lineOfCode := nodeContext methodNode selector asString ].
		
	lineCounter := 0.
	sourceCodeStream contents lines do: [ 
		:line |
			lineCounter := lineCounter + 1. 
			(line indexOfSubCollection: lineOfCode) > 0 ifTrue: [ 
				lineNumber := lineCounter.
			] 
		].
		
	contextProperty := ContextProperty getInstance
		stepName: 'BreakpointAdd';
		methodName: nodeContext methodNode selector asString;
		className: nodeContext methodNode methodClass asString;
		packageName: (self getNamespace: nodeContext methodNode methodClass asString);
		sourceCode: sourceCodeStream contents; 
		lineOfCode: lineOfCode;
		lineNumber: lineNumber;
		charStart: nodeContext start;
		charEnd: nodeContext stop.
		
	contextProperty filePath: (self processCodeFile: contextProperty).

	"Breakpoint"
	breakpointData := BreakpointData new 
		id: UUID new printString;
		breakpointKind: contextProperty stepName;
		namespace: contextProperty packageName;
		type: contextProperty className;
		codeFilePath: contextProperty filePath;
		lineNumber: contextProperty lineNumber;
		lineOfCode: contextProperty lineOfCode;
		origin: 'AddedDuringDebug';
		created: DateAndTime now.
	
	alreadyExist := false.
	currentSession breakpoints do: [
		:breakpointItem | 
			(breakpointItem codeFilePath = breakpointData codeFilePath) &
			(breakpointItem lineNumber = breakpointData lineNumber)
			ifTrue: [ 
				alreadyExist := true 
			] 
		].
	
	alreadyExist ifFalse: [ 
			self processEvent: contextProperty.
			Transcript show: 'adicionou no array'; cr.
			currentSession breakpoints add: breakpointData. 
			
			Repository save: currentSession.
		 ].

]

{ #category : #public }
SessionService class >> registerNewSession: context [

	currentSession ifNotNil: [ ^self ].

	swarmWindowData ifNil:[ swarmWindowData := 
		WindowProperty new 
			projectName: 'Pharo Project Sample'; 
			developerName:'I am a Developer';
			taskName: 'This is my current task';
			taskAction: 'SearchingBug';
			taskDescription: ''
		].

	currentSession := 
		SessionData new 
			id: UUID new printString; 
			description: 'Swarm on Pharo';			
			started: DateAndTime now;
			developerName: swarmWindowData developerName;
			taskName: swarmWindowData taskName;
			taskAction: swarmWindowData taskAction;
			taskDescription: swarmWindowData taskDescription;
			taskCreated: nil; "revisar depois"
			taskTotalSessionTime: '00:00:00.0000000';
			projectName: swarmWindowData projectName;
			breakpoints: OrderedCollection new;
			codeFiles: OrderedCollection new;
			events: OrderedCollection new;
			pathNodes: OrderedCollection new.

	Repository save: currentSession.
	
	self registerAlreadyAddedBreakpoints.
]

{ #category : #public }
SessionService class >> registerNewSessionFromDebugWindow: context [

	currentSession ifNotNil: [ ^self ].

	self registerNewSession: context.
	
	self processStep: context stepName: 'StepInto'.
]

{ #category : #public }
SessionService class >> registerStepInto: context [

	self registerNewSession: context.
	
	self processStep: context stepName: 'StepInto'.
]

{ #category : #public }
SessionService class >> registerStepOver: context [

	self registerNewSession: context.

	self processStep: context stepName: 'StepOver'.
	

]

{ #category : #initialization }
SessionService class >> reset [
	<script: 'self reset'>
	currentSession := nil
]

{ #category : #public }
SessionService class >> setSwarmWindowData: windowProPerty [
	swarmWindowData := windowProPerty
]
