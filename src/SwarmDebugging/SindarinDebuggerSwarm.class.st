Class {
	#name : #SindarinDebuggerSwarm,
	#superclass : #SindarinDebugger,
	#instVars : [
		'recordStep'
	],
	#category : #'SwarmDebugging-SindarinInterface'
}

{ #category : #'as yet unclassified' }
SindarinDebuggerSwarm class >> debug: aBlock [
	
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
	self addStepHook: [ (self message: #break to: Break) ifTrue: [ self skip ] ].
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

{ #category : #'stepping - steps' }
SindarinDebuggerSwarm >> stepThrough [ 
	self recordStep ifTrue: [ SessionService registerStepInto: self context].
	"TODO: needs to be created the StepThrough concept on Swarm model."
	"TODO: StepThrough doesn't work well even in isolated Sindarin."
	super stepThrough.
]
