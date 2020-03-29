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
