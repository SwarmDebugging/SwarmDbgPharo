Class {
	#name : #ProcessorOfWatchpointObjectHit,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfWatchpointObjectHit >> initialize [ 
	self stepName: 'WatchpointObjectHitted'.
]

{ #category : #'as yet unclassified' }
ProcessorOfWatchpointObjectHit >> process: aBreakpointNode variableValue: aValue instance: aObject [
 
	| variableExist |

	self extract: aBreakpointNode.
	
	self objectId: aObject identityHash asString.
	self variableValue: aValue.
	
	variableExist := false.
	
	aBreakpointNode class allInstVarNames do: [ :item | (item = #variable) ifTrue: [ variableExist := true. ] ].

	self variableName: (variableExist ifFalse: [ aBreakpointNode name ] ifTrue: [ aBreakpointNode variable name ] ).

	self processCodeFile.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
]
