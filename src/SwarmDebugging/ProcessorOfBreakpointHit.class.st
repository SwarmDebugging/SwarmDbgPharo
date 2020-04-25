Class {
	#name : #ProcessorOfBreakpointHit,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfBreakpointHit >> initialize [ 
	self stepName: 'BreakpointHitted'.
]
