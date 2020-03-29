Extension { #name : #Breakpoint }

{ #category : #'*SwarmDebugging' }
Breakpoint >> install [
	SessionService registerBreakpoint: self node.

	AllBreakpoints add: self.
	self node link: self link
]
