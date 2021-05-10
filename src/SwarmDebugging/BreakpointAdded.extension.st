Extension { #name : #BreakpointAdded }

{ #category : #'*SwarmDebugging' }
BreakpointAdded >> registerWith: aSwarmObserver [
	aSwarmObserver registerBreakpointAdd: self
]
