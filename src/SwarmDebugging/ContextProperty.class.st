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

{ #category : #'as yet unclassified' }
ContextProperty >> charEnd [
	^charEnd
]

{ #category : #'as yet unclassified' }
ContextProperty >> charEnd: value [
	charEnd := value
]

{ #category : #'as yet unclassified' }
ContextProperty >> charStart [
	^charStart
]

{ #category : #'as yet unclassified' }
ContextProperty >> charStart: value [
	charStart := value
]

{ #category : #'as yet unclassified' }
ContextProperty >> className [
	^className
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ContextProperty >> filePath [
	^filePath
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ContextProperty >> lineNumber [
	^lineNumber
]

{ #category : #'as yet unclassified' }
ContextProperty >> lineNumber: value [
	lineNumber := value
]

{ #category : #'as yet unclassified' }
ContextProperty >> lineOfCode [
	^lineOfCode
]

{ #category : #'as yet unclassified' }
ContextProperty >> lineOfCode: value [
	lineOfCode := value
]

{ #category : #'as yet unclassified' }
ContextProperty >> methodName [
	^methodName
]

{ #category : #'as yet unclassified' }
ContextProperty >> methodName: value [
	methodName := value
]

{ #category : #'as yet unclassified' }
ContextProperty >> packageName [
	^packageName
]

{ #category : #'as yet unclassified' }
ContextProperty >> packageName: value [
	packageName := value
]

{ #category : #'as yet unclassified' }
ContextProperty >> sourceCode [
	^sourceCode
]

{ #category : #'as yet unclassified' }
ContextProperty >> sourceCode: value [
	sourceCode := value
]

{ #category : #'as yet unclassified' }
ContextProperty >> stepName [
	^stepName
]

{ #category : #'as yet unclassified' }
ContextProperty >> stepName: value [
	stepName := value
]
