"
I register step actions in the swarm instance.
"
Class {
	#name : #SwarmStepIntoCommand,
	#superclass : #StStepIntoCommand,
	#category : #'SwarmDebugging-Interface-Debugger'
}

{ #category : #execution }
SwarmStepIntoCommand >> execute [
	SessionService registerStepInto: self debugger currentContext.
	super execute
]
