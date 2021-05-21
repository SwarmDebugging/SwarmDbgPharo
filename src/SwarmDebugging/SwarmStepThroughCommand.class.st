"
I register step through actions in the swarm instance.
"
Class {
	#name : #SwarmStepThroughCommand,
	#superclass : #StStepThroughCommand,
	#category : #'SwarmDebugging-Interface-Debugger'
}

{ #category : #execution }
SwarmStepThroughCommand >> execute [

	SessionService registerStepInto: self debugger currentContext.
	super execute
]
