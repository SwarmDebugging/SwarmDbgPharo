"
I am a swarm single debugger selector that controls that we create a new swarm session for each opening debugger.
"
Class {
	#name : #SwarmSingleDebuggerSelector,
	#superclass : #OupsSingleDebuggerSelector,
	#category : #'SwarmDebugging-Interface-Debugger'
}

{ #category : #debuggers }
SwarmSingleDebuggerSelector >> openDebuggerForSession: aDebugSession [

	SessionService registerNewSession.
	super openDebuggerForSession: aDebugSession
]
