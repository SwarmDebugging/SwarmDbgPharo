Class {
	#name : #PathNode,
	#superclass : #Object,
	#instVars : [
		'id',
		'hash',
		'namespace',
		'type',
		'method',
		'parent',
		'parent_Id',
		'origin',
		'returnType',
		'parameters',
		'created',
		'event_Id'
	],
	#category : #'SwarmDebugging-Service-DataModel'
}

{ #category : #accessing }
PathNode >> created: value [

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
PathNode >> event_Id: value [
	event_Id := value
]

{ #category : #accessing }
PathNode >> hash: value [
	hash := value
]

{ #category : #accessing }
PathNode >> id [
	^id
]

{ #category : #accessing }
PathNode >> id: value [
	id := value
]

{ #category : #accessing }
PathNode >> method: value [
	method := value
]

{ #category : #accessing }
PathNode >> namespace: value [
	namespace := value
]

{ #category : #accessing }
PathNode >> origin: value [
	origin := value
]

{ #category : #accessing }
PathNode >> parameters: value [
	parameters := value
]

{ #category : #accessing }
PathNode >> parent: value [
	parent := value
]

{ #category : #accessing }
PathNode >> parent_Id: value [
	parent_Id := value
]

{ #category : #accessing }
PathNode >> returnType: value [
	returnType := value
]

{ #category : #accessing }
PathNode >> type: value [
	type := value
]
