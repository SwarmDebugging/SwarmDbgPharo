Class {
	#name : #ProcessorOfDebuggerOpening,
	#superclass : #ProcessorOfStep,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfDebuggerOpening >> initialize [ 
	self stepName: 'Opening debugger'
]
