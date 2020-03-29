Class {
	#name : #SessionData,
	#superclass : #Object,
	#instVars : [
		'id',
		'description',
		'started',
		'finished',
		'developerName',
		'taskName',
		'taskAction',
		'taskDescription',
		'taskCreated',
		'taskTotalSessionTime',
		'projectName',
		'breakpoints',
		'codeFiles',
		'events',
		'pathNodes'
	],
	#category : #'SwarmDebugging-Service-DataModel'
}

{ #category : #accessing }
SessionData >> breakpoints [
	^breakpoints
]

{ #category : #accessing }
SessionData >> breakpoints: value [
	breakpoints := value
]

{ #category : #accessing }
SessionData >> codeFiles [
	^codeFiles
]

{ #category : #accessing }
SessionData >> codeFiles: value [
	codeFiles := value
]

{ #category : #accessing }
SessionData >> description: value [
	description := value
]

{ #category : #accessing }
SessionData >> developerName: value [
	developerName := value
]

{ #category : #accessing }
SessionData >> events [
	^events
]

{ #category : #accessing }
SessionData >> events: value [
	events := value
]

{ #category : #accessing }
SessionData >> finished: value [

	|d s|
	d := value.
	s := d month asString, '/', 
	d dayOfMonth asString, '/', 
	d year asString, ' ', 
	d hour24 asString, ':', 
	d minute asString, ':', 
	d second asString, '.',
	d nanoSecond asString.

	finished := s.
]

{ #category : #accessing }
SessionData >> id: value [
	id := value
]

{ #category : #accessing }
SessionData >> pathNodes [
	^pathNodes
]

{ #category : #accessing }
SessionData >> pathNodes: value [
	pathNodes := value
]

{ #category : #accessing }
SessionData >> projectName: value [
	projectName := value
]

{ #category : #accessing }
SessionData >> started: value [

	|d s|
	d := value.
	s := d month asString, '/',
	d dayOfMonth asString, '/', 
	d year asString, ' ', 
	d hour24 asString, ':', 
	d minute asString, ':', 
	d second asString, '.',
	d nanoSecond asString.

	started := s.
]

{ #category : #accessing }
SessionData >> taskAction: value [
	taskAction := value
]

{ #category : #accessing }
SessionData >> taskCreated: value [
	taskCreated := value
]

{ #category : #accessing }
SessionData >> taskDescription: value [
	taskDescription := value
]

{ #category : #accessing }
SessionData >> taskName: value [
	taskName := value
]

{ #category : #accessing }
SessionData >> taskTotalSessionTime: value [
	taskTotalSessionTime := value
]
