Extension { #name : #VariableBreakpoint }

{ #category : #'*SwarmDebugging' }
VariableBreakpoint >> registerBreakpointAdded: anAnnouncement in: observer [
	observer updateSessionWithVariableBreakpointAdded: anAnnouncement 
]

{ #category : #'*SwarmDebugging' }
VariableBreakpoint >> registerBreakpointHit: anAnnouncement in: observer [
	observer updateSessionWithVariableBreakpointHit: anAnnouncement 
]

{ #category : #'*SwarmDebugging' }
VariableBreakpoint >> registerBreakpointRemoved: anAnnouncement in: observer [
	observer updateSessionWithVariableBreakpointRemoved: anAnnouncement 
]
