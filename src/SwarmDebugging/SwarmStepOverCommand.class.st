"
I register step over actions in the swarm instance.
"
Class {
	#name : #SwarmStepOverCommand,
	#superclass : #StStepOverCommand,
	#category : #'SwarmDebugging-Interface-Debugger'
}

{ #category : #execution }
SwarmStepOverCommand >> execute [

	SessionService registerStepOver: self debugger currentContext.
	super execute
]
