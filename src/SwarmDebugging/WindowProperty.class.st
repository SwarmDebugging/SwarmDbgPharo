Class {
	#name : #WindowProperty,
	#superclass : #Object,
	#instVars : [
		'projectName',
		'developerName',
		'taskName',
		'taskAction',
		'taskDescription',
		'taskCreated'
	],
	#category : #'SwarmDebugging-DataModel'
}

{ #category : #accessing }
WindowProperty >> developerName [
	^ developerName
]

{ #category : #accessing }
WindowProperty >> developerName: anObject [
	developerName := anObject
]

{ #category : #accessing }
WindowProperty >> projectName [
	^ projectName
]

{ #category : #accessing }
WindowProperty >> projectName: anObject [
	projectName := anObject
]

{ #category : #accessing }
WindowProperty >> taskAction [
	^ taskAction
]

{ #category : #accessing }
WindowProperty >> taskAction: anObject [
	taskAction := anObject
]

{ #category : #accessing }
WindowProperty >> taskCreated [
	^ taskCreated
]

{ #category : #accessing }
WindowProperty >> taskCreated: anObject [
	taskCreated := anObject
]

{ #category : #accessing }
WindowProperty >> taskDescription [
	^ taskDescription
]

{ #category : #accessing }
WindowProperty >> taskDescription: anObject [
	taskDescription := anObject
]

{ #category : #accessing }
WindowProperty >> taskName [
	^ taskName
]

{ #category : #accessing }
WindowProperty >> taskName: anObject [
	taskName := anObject
]
