Class {
	#name : #Event,
	#superclass : #Object,
	#instVars : [
		'id',
		'eventKind',
		'detail',
		'namespace',
		'type',
		'typeFullPath',
		'method',
		'methodKey',
		'methodSignature',
		'charStart',
		'charEnd',
		'codeFilePath',
		'lineNumber',
		'lineOfCode',
		'created'
	],
	#category : #'SwarmDebugging-Service-DataModel'
}

{ #category : #accessing }
Event >> charEnd: value [
	charEnd := value
]

{ #category : #accessing }
Event >> charStart: value [
	charStart := value
]

{ #category : #accessing }
Event >> codeFilePath: value [
	codeFilePath := value
]

{ #category : #accessing }
Event >> created: value [

	|d s|
	d := value.
	s := d month asString, '/',
	d dayOfMonth asString, '/', 
	d year asString, ' ', 
	d hour24 asString, ':', 
	d minute asString, ':', 
	d second asString, '.',
	d nanoSecond asString.

	created := s
]

{ #category : #accessing }
Event >> detail: value [
	detail := value
]

{ #category : #accessing }
Event >> eventKind: value [
	eventKind := value
]

{ #category : #accessing }
Event >> id: value [
	id := value
]

{ #category : #accessing }
Event >> lineNumber: value [
	lineNumber := value
]

{ #category : #accessing }
Event >> lineOfCode: value [
	lineOfCode := value
]

{ #category : #accessing }
Event >> method: value [
	method := value
]

{ #category : #accessing }
Event >> methodKey: value [
	methodKey := value
]

{ #category : #accessing }
Event >> methodSignature: value [
	methodSignature := value
]

{ #category : #accessing }
Event >> namespace: value [
	namespace := value
]

{ #category : #accessing }
Event >> type: value [
	type := value
]

{ #category : #accessing }
Event >> typeFullPath: value [
	typeFullPath := value
]
