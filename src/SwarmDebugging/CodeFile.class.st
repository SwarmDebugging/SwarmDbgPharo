Class {
	#name : #CodeFile,
	#superclass : #Object,
	#instVars : [
		'id',
		'path',
		'content',
		'created'
	],
	#category : #'SwarmDebugging-Service-DataModel'
}

{ #category : #accessing }
CodeFile >> content: value [
	content := value
]

{ #category : #accessing }
CodeFile >> created: value [
	created := value
]

{ #category : #accessing }
CodeFile >> id: value [
	id := value
]

{ #category : #accessing }
CodeFile >> path [
	^path
]

{ #category : #accessing }
CodeFile >> path: value [
	path := value
]
