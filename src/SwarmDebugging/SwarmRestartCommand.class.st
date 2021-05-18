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
