Class {
	#name : #SindarinDebuggerSwarm,
	#superclass : #SindarinDebugger,
	#instVars : [
		'recordStep'
	],
	#category : #'SwarmDebugging-Service-Sindarin'
}

{ #category : #'as yet unclassified' }
SindarinDebuggerSwarm class >> debugSwarm: aBlock [
	
	| instance |
	SessionService registerNewSession.
	
	instance := self new debug: aBlock.
	instance recordStep: true.
	^ instance
]

{ #category : #'stepping - steps' }
SindarinDebuggerSwarm >> initialize [
	recordStep := false.
	super initialize.
]

{ #category : #accessing }
SindarinDebuggerSwarm >> recordStep [
	^ recordStep
]

{ #category : #accessing }
SindarinDebuggerSwarm >> recordStep: aValue [
	recordStep := aValue
]

{ #category : #'stepping - steps' }
SindarinDebuggerSwarm >> step [
	self recordStep ifTrue: [ SessionService registerStepInto: self context].
	super step.
]

{ #category : #'stepping - steps' }
SindarinDebuggerSwarm >> stepOver [
	SessionService registerStepOver: self context.
	self recordStep: false.
	super stepOver.
	self recordStep: true.
]
