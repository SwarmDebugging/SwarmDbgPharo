Class {
	#name : #BreakpointObserver,
	#superclass : #Object,
	#category : #'SwarmDebugging-Interface-Pharo'
}

{ #category : #updating }
BreakpointObserver >> update: aNotification [

	aNotification breakpoint isWatchpoint ifFalse: [ 
		(aNotification class className = BreakpointActivationNotification className) ifTrue: [ SessionService registerBreakpointActive: aNotification breakpoint node. ].
		(aNotification class className = BreakpointAddedNotification className) ifTrue: [ SessionService registerBreakpointAdd: aNotification breakpoint node. ].
		(aNotification class className = BreakpointRemovedNotification className) ifTrue: [ SessionService registerBreakpointRemove: aNotification breakpoint node. ].
		(aNotification class className = BreakpointHitNotification className) ifTrue: [ SessionService registerBreakpointHit: aNotification breakpoint node. ].
	] ifTrue: [
		aNotification breakpoint targetInstance 
			ifNil: [ 
				(aNotification class className = BreakpointAddedNotification className) ifTrue: [ 
						aNotification nodes do: [ :node | SessionService registerWatchpointAdd: node ].
						aNotification breakpoint targetVariableNames do: [ :item | SessionService registerWatchpointVariableAdd: item  targetClass: aNotification breakpoint targetClassOrMethod] 
					].
				(aNotification class className = BreakpointRemovedNotification className) ifTrue: [ 
						aNotification nodes do: [ :node | SessionService registerWatchpointRemove: node ].
						aNotification breakpoint targetVariableNames do: [ :item | SessionService registerWatchpointVariableRemove: item  targetClass: aNotification breakpoint targetClassOrMethod] 
					].
				(aNotification class className = BreakpointHitNotification className) ifTrue: [ 
						SessionService registerWatchpointHit: aNotification nodes first variableValue: aNotification valueOrNil.
					].
				 ] 
			ifNotNil: [ 
				(aNotification class className = BreakpointAddedNotification className) ifTrue: [ 
							aNotification nodes do: [ :node | SessionService registerWatchpointAdd: node instanceObject: (aNotification breakpoint targetInstance) ].
							aNotification breakpoint targetVariableNames do: [ :item | SessionService registerWatchpointVariableAdd: item  targetInstance: aNotification breakpoint targetInstance] 
						].
				(aNotification class className = BreakpointRemovedNotification className) ifTrue: [ 
							aNotification nodes do: [ :node | SessionService registerWatchpointRemove: node instanceObject: (aNotification breakpoint targetInstance) ].
							aNotification breakpoint targetVariableNames do: [ :item | SessionService registerWatchpointVariableRemove: item  targetInstance: aNotification breakpoint targetInstance] 
						].
				(aNotification class className = BreakpointHitNotification className) ifTrue: [ 
							SessionService registerWatchpointHit: aNotification nodes first variableValue: (aNotification valueOrNil) targetInstance: aNotification breakpoint targetInstance.
						].					
				 ].	
	]
]
