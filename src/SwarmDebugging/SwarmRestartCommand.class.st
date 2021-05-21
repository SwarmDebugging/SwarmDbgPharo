"
I register restart actions in the swarm instance.
"
Class {
	#name : #SwarmRestartCommand,
	#superclass : #StRestartCommand,
	#category : #'SwarmDebugging-Interface-Debugger'
}

{ #category : #execution }
SwarmRestartCommand >> execute [

	SessionService registerRestart: self debugger currentContext.
	super execute
]
