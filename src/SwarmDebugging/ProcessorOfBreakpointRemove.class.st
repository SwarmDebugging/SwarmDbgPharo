Class {
	#name : #ProcessorOfBreakpointRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointRemove >> initialize [ 
	self stepName: 'BreakpointRemove'.
]
