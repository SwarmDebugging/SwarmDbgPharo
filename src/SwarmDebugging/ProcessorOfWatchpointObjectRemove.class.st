Class {
	#name : #ProcessorOfWatchpointObjectRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointObjectRemove >> extract: aContext [ 

	| variableExist valueExist |
	
	variableExist := false.
	valueExist := false.
	
	aContext class allInstVarNames do: [ :item | (item = #variable) ifTrue: [ variableExist := true. ] ].
	aContext class allInstVarNames do: [ :item | (item = #value) ifTrue: [ valueExist := true. ] ].

	self variableName: (variableExist ifFalse: [ aContext name ] ifTrue: [ aContext variable name ] ).
	self variableValue: (valueExist ifTrue: [ aContext value name ]).
	
	super extract: aContext.
]

{ #category : #initialization }
ProcessorOfWatchpointObjectRemove >> initialize [ 
	self stepName: 'WatchpointObjectRemove'.
]

{ #category : #process }
ProcessorOfWatchpointObjectRemove >> process: aWatchpointNode instanceObject: instanceObject [
	
	self objectId: instanceObject identityHash.
	
	self extract: aWatchpointNode.
		
	self processCodeFile.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
]
