Extension { #name : #BreakpointRemoved }

{ #category : #'*SwarmDebugging' }
BreakpointRemoved >> registerWith: aSwarmObserver [
	aSwarmObserver registerBreakpointRemoved: self
]
