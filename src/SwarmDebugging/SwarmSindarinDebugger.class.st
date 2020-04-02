Class {
	#name : #SwarmSindarinDebugger,
	#superclass : #SindarinDebugger,
	#instVars : [
		'recordStep'
	],
	#category : #SwarmDebugging
}

{ #category : #'stepping - steps' }
SwarmSindarinDebugger >> initialize [
	recordStep := false.
	super initialize.
]

{ #category : #accessing }
SwarmSindarinDebugger >> recordStep [
	^ recordStep
]

{ #category : #accessing }
SwarmSindarinDebugger >> recordStep: aValue [
	recordStep := aValue
]

{ #category : #'stepping - steps' }
SwarmSindarinDebugger >> step [
	self recordStep ifTrue: [ SessionService registerStepInto: self context].
	super step.
]

{ #category : #'stepping - steps' }
SwarmSindarinDebugger >> stepOver [
	SessionService registerStepOver: self context.
	self recordStep: false.
	super stepOver.
	self recordStep: true.
]
