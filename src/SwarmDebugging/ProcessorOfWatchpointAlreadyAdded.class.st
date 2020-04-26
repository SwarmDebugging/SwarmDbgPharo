Class {
	#name : #ProcessorOfWatchpointAlreadyAdded,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointAlreadyAdded >> extract: aContext [ 

	self variableName: (aContext variable ifNil: [ aContext name ] ifNotNil: [ aContext variable name ] ).
	self variableValue: (aContext value ifNotNil: [ aContext value name ]).
]

{ #category : #initialization }
ProcessorOfWatchpointAlreadyAdded >> initialize [ 
	self stepName: 'WatchpointAdd'.
	self kind: 'Watchpoint'.
	self origin: 'AddedBeforeDebug'.
]

{ #category : #accessing }
ProcessorOfWatchpointAlreadyAdded >> process: aWatchpointNode [
		
	self extract: aWatchpointNode.
	
	super process: aWatchpointNode.

	SessionService getCurrentSession addBreakpoint: self processBreakpoint.
			
	Repository save: SessionService getCurrentSession.
]
