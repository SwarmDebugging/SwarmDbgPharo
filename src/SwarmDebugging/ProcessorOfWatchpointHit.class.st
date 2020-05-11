Class {
	#name : #ProcessorOfWatchpointHit,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointHit >> initialize [ 
	self stepName: 'WatchpointHitted'.
]

{ #category : #'as yet unclassified' }
ProcessorOfWatchpointHit >> process: aBreakpointNode variableValue: aValue [
 
	| variableExist |

	self extract: aBreakpointNode.
	
	self variableValue: aValue.
	
	variableExist := false.
	
	aBreakpointNode class allInstVarNames do: [ :item | (item = #variable) ifTrue: [ variableExist := true. ] ].

	self variableName: (variableExist ifFalse: [ aBreakpointNode name ] ifTrue: [ aBreakpointNode variable name ] ).

	self processCodeFile.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
]
