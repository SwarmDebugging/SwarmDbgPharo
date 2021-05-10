Extension { #name : #BreakpointHit }

{ #category : #'*SwarmDebugging' }
BreakpointHit >> registerWith: aSwarmObserver [
	aSwarmObserver registerBreakpointHit: self
]
