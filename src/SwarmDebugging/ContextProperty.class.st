Class {
	#name : #ContextProperty,
	#superclass : #Object,
	#instVars : [
		'methodName',
		'className',
		'packageName',
		'sourceCode',
		'lineOfCode',
		'lineNumber',
		'charStart',
		'charEnd',
		'stepName',
		'filePath'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #'instance creation' }
ContextProperty class >> getInstance [ 
	^self new 
	methodName: 'NotDefined';
	className: 'NotDefined';
	packageName: 'NotDefined';
	sourceCode: 'NotDefined';
	lineOfCode: 'NotDefined';
	lineNumber: 0;
	charStart: 0;
	charEnd: 0.
	
"Needs too be removed later."
]

{ #category : #accessing }
ContextProperty >> charEnd [
	^charEnd
]

{ #category : #accessing }
ContextProperty >> charEnd: value [
	charEnd := value
]

{ #category : #accessing }
ContextProperty >> charStart [
	^charStart
]

{ #category : #accessing }
ContextProperty >> charStart: value [
	charStart := value
]

{ #category : #accessing }
ContextProperty >> className [
	^className
]

{ #category : #accessing }
ContextProperty >> className: value [
	className := value
]

{ #category : #process }
ContextProperty >> extract: aContext [
	
	| typeWord lineOfCodeNode |
	
	typeWord := aContext methodClass asString.
	((typeWord indexOfSubCollection: ' class') asNumber > 1) ifTrue: [
			typeWord := typeWord copyFrom: 1 to: (typeWord indexOfSubCollection: ' class') - 1
		].

	lineOfCodeNode := (aContext method sourceNodeForPC: aContext pc).
	
	self packageName: (SessionService getNamespace: typeWord).
	self className: typeWord.
	self methodName: aContext methodSelector asString.
	self sourceCode: (aContext sourceCode asString) contents.
	self charStart: lineOfCodeNode start.
	self charEnd: lineOfCodeNode stop.	
	self lineOfCode: ( lineOfCodeNode source copyFrom: self charStart to: self charEnd ) asString.
	self lineNumber: (lineOfCodeNode source copyFrom: 1 to: self charStart ) asString lineCount.

	^self.
		
]

{ #category : #accessing }
ContextProperty >> filePath [
	^filePath
]

{ #category : #accessing }
ContextProperty >> filePath: value [
	filePath := value
]

{ #category : #initialization }
ContextProperty >> initialize [ 
	self methodName: 'NotDefined'.
	self className: 'NotDefined'.
	self packageName: 'NotDefined'.
	self sourceCode: 'NotDefined'.
	self lineOfCode: 'NotDefined'.
	self lineNumber: 0.
	self charStart: 0.
	self charEnd: 0.
]

{ #category : #accessing }
ContextProperty >> lineNumber [
	^lineNumber
]

{ #category : #accessing }
ContextProperty >> lineNumber: value [
	lineNumber := value
]

{ #category : #accessing }
ContextProperty >> lineOfCode [
	^lineOfCode
]

{ #category : #accessing }
ContextProperty >> lineOfCode: value [
	lineOfCode := value
]

{ #category : #accessing }
ContextProperty >> methodName [
	^methodName
]

{ #category : #accessing }
ContextProperty >> methodName: value [
	methodName := value
]

{ #category : #accessing }
ContextProperty >> packageName [
	^packageName
]

{ #category : #accessing }
ContextProperty >> packageName: value [
	packageName := value
]

{ #category : #accessing }
ContextProperty >> sourceCode [
	^sourceCode
]

{ #category : #accessing }
ContextProperty >> sourceCode: value [
	sourceCode := value
]

{ #category : #accessing }
ContextProperty >> stepName [
	^stepName
]

{ #category : #accessing }
ContextProperty >> stepName: value [
	stepName := value
]
