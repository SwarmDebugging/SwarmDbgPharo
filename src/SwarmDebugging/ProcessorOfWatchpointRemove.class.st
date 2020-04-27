Class {
	#name : #ProcessorOfWatchpointRemove,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfWatchpointRemove >> extract: aContext [ 

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
ProcessorOfWatchpointRemove >> initialize [ 
	self stepName: 'WatchpointRemove'.
]
