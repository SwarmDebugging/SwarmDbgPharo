Class {
	#name : #ProcessorOfBreakpointActive,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointActive >> initialize [ 
	self stepName: 'BreakpointActive'.
]
