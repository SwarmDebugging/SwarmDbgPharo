Extension { #name : #Breakpoint }

{ #category : #'*SwarmDebugging' }
Breakpoint >> registerBreakpointAdded: anAnnouncement in: observer [
	observer updateSessionWithBreakpointAdded: anAnnouncement 
]

{ #category : #'*SwarmDebugging' }
Breakpoint >> registerBreakpointHit: anAnnouncement in: observer [
	observer updateSessionWithBreakpointHit: anAnnouncement 
]

{ #category : #'*SwarmDebugging' }
Breakpoint >> registerBreakpointRemoved: anAnnouncement in: observer [
	observer updateSessionWithBreakpointRemoved: anAnnouncement 
]
