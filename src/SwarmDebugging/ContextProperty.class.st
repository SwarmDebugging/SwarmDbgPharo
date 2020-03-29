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
	#category : #'SwarmDebugging-DataModel'
}

{ #category : #'instance creation' }
ContextProperty class >> getInstance [ 
	^ContextProperty new 
	methodName: 'NotDefined';
	className: 'NotDefined';
	packageName: 'NotDefined';
	sourceCode: 'NotDefined';
	lineOfCode: 'NotDefined';
	lineNumber: 0;
	charStart: 0;
	charEnd: 0.
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

{ #category : #'as yet unclassified' }
ContextProperty >> filePath [
	^filePath
]

{ #category : #'as yet unclassified' }
ContextProperty >> filePath: value [
	filePath := value
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
