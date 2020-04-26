Class {
	#name : #ProcessorOfSession,
	#superclass : #Object,
	#instVars : [
		'event',
		'event_id',
		'methodName',
		'className',
		'packageName',
		'sourceCode',
		'lineOfCode',
		'lineNumber',
		'charStart',
		'charEnd',
		'stepName',
		'filePath',
		'objectId',
		'variableName',
		'variableValue'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #accessing }
ProcessorOfSession >> charEnd [
	^charEnd
]

{ #category : #accessing }
ProcessorOfSession >> charEnd: value [
	charEnd := value
]

{ #category : #accessing }
ProcessorOfSession >> charStart [
	^charStart
]

{ #category : #accessing }
ProcessorOfSession >> charStart: value [
	charStart := value
]

{ #category : #accessing }
ProcessorOfSession >> className [
	^className
]

{ #category : #accessing }
ProcessorOfSession >> className: value [
	className := value
]

{ #category : #accessing }
ProcessorOfSession >> event [
	^ event
]

{ #category : #accessing }
ProcessorOfSession >> event: anObject [
	event := anObject
]

{ #category : #accessing }
ProcessorOfSession >> event_id [
	^ event_id
]

{ #category : #accessing }
ProcessorOfSession >> event_id: value [
	event_id := value
]

{ #category : #accessing }
ProcessorOfSession >> filePath [
	^filePath
]

{ #category : #accessing }
ProcessorOfSession >> filePath: value [
	filePath := value
]

{ #category : #accessing }
ProcessorOfSession >> lineNumber [
	^lineNumber
]

{ #category : #accessing }
ProcessorOfSession >> lineNumber: value [
	lineNumber := value
]

{ #category : #accessing }
ProcessorOfSession >> lineOfCode [
	^lineOfCode
]

{ #category : #accessing }
ProcessorOfSession >> lineOfCode: value [
	lineOfCode := value
]

{ #category : #accessing }
ProcessorOfSession >> methodName [
	^methodName
]

{ #category : #accessing }
ProcessorOfSession >> methodName: value [
	methodName := value
]

{ #category : #accessing }
ProcessorOfSession >> objectId [
	^ objectId
]

{ #category : #accessing }
ProcessorOfSession >> objectId: anObject [
	objectId := anObject
]

{ #category : #accessing }
ProcessorOfSession >> packageName [
	^packageName
]

{ #category : #accessing }
ProcessorOfSession >> packageName: value [
	packageName := value
]

{ #category : #process }
ProcessorOfSession >> processCodeFile [

	| codeFile alreadyExist |

	self filePath: (FileLocator imageDirectory / self packageName / self className, 'st') pathString.	

	codeFile := CodeFile new 
		id: UUID new printString;
		path: self filePath;
		content: (ZnBase64Encoder new encode: (self sourceCode) asByteArray);
		created: DateAndTimeSwarm now.
	
	alreadyExist := false.
	SessionService getCurrentSession codeFiles do: [ 
		:file | file path = (self filePath) ifTrue: [ 
			alreadyExist := true 
			] 
		].
	
	alreadyExist ifTrue: [ ^self ].

	SessionService getCurrentSession addCodeFile: codeFile. 
	
]

{ #category : #process }
ProcessorOfSession >> processEvent [

	self event_id: UUID new printString.

	self event ifNil: [ self event: Event new. ].

	self event id: self event_id.
	self event eventKind: self stepName.
	self event detail: 'TODO'.
	self event namespace: self packageName.
	self event type: self className.
	self event typeFullPath: 'TODO'.
	self event method: self methodName.
	self event methodKey: ''.
	self event methodSignature: ''.
	self event charStart: self charStart.
	self event charEnd: self charEnd.
	self event codeFilePath: self filePath.
	self event lineNumber: self lineNumber.
	self event lineOfCode: self lineOfCode.
	self event created: DateAndTimeSwarm now.
	self event objectId: self objectId.
	self event variableName: self variableName.
	self event variableValue: self variableValue.
		
	SessionService getCurrentSession addEvent: self event.

	
]

{ #category : #accessing }
ProcessorOfSession >> sourceCode [
	^sourceCode
]

{ #category : #accessing }
ProcessorOfSession >> sourceCode: value [
	sourceCode := value
]

{ #category : #accessing }
ProcessorOfSession >> stepName [
	^stepName
]

{ #category : #accessing }
ProcessorOfSession >> stepName: value [
	stepName := value
]

{ #category : #accessing }
ProcessorOfSession >> variableName [
	^ variableName
]

{ #category : #accessing }
ProcessorOfSession >> variableName: anObject [
	variableName := anObject
]

{ #category : #accessing }
ProcessorOfSession >> variableValue [
	^ variableValue
]

{ #category : #accessing }
ProcessorOfSession >> variableValue: anObject [
	variableValue := anObject
]
