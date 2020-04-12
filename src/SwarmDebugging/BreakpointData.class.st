Class {
	#name : #BreakpointData,
	#superclass : #Object,
	#instVars : [
		'id',
		'breakpointKind',
		'namespace',
		'type',
		'codeFilePath',
		'lineNumber',
		'lineOfCode',
		'origin',
		'created'
	],
	#category : #'SwarmDebugging-Service-DataModel'
}

{ #category : #accessing }
BreakpointData >> breakpointKind: value [
	breakpointKind := value
]

{ #category : #accessing }
BreakpointData >> codeFilePath [
	^codeFilePath
]

{ #category : #accessing }
BreakpointData >> codeFilePath: value [
	codeFilePath := value
]

{ #category : #accessing }
BreakpointData >> created: value [
	created := value
]

{ #category : #accessing }
BreakpointData >> id [
	^id
]

{ #category : #accessing }
BreakpointData >> id: value [
	id := value
]

{ #category : #accessing }
BreakpointData >> lineNumber [
	^lineNumber
]

{ #category : #accessing }
BreakpointData >> lineNumber: value [
	lineNumber := value
]

{ #category : #accessing }
BreakpointData >> lineOfCode: value [
	lineOfCode := value
]

{ #category : #accessing }
BreakpointData >> namespace: value [
	namespace := value
]

{ #category : #accessing }
BreakpointData >> origin: value [
	origin := value
]

{ #category : #accessing }
BreakpointData >> type: value [
	type := value
]
