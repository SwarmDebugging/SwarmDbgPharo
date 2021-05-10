"
I listen to BreakpointAnnouncements. Upon such announcement, I register the related breakpoints to the Swarm session.
"
Class {
	#name : #BreakpointObserver,
	#superclass : #Object,
	#category : #'SwarmDebugging-Interface-Pharo'
}

{ #category : #initialization }
BreakpointObserver >> initialize [

	super initialize.
	BreakpointAnnouncement subclassesDo: [ :ann | 
		SystemAnnouncer uniqueInstance weak
			when: ann
			send: #registerBreakpointAnnouncement:
			to: self ]
]

{ #category : #registering }
BreakpointObserver >> registerBreakpointAdd: anAnnouncement [

	anAnnouncement breakpoint registerBreakpointAdded: anAnnouncement in: self
]

{ #category : #registering }
BreakpointObserver >> registerBreakpointAnnouncement: aBreakpointAnnouncement [

	aBreakpointAnnouncement registerWith: self
]

{ #category : #registering }
BreakpointObserver >> registerBreakpointHit: anAnnouncement [

	anAnnouncement breakpoint registerBreakpointHit: anAnnouncement in: self
]

{ #category : #registering }
BreakpointObserver >> registerBreakpointRemoved: anAnnouncement [

	anAnnouncement breakpoint registerBreakpointRemoved: anAnnouncement in: self
]

{ #category : #updating }
BreakpointObserver >> updateSessionWithBreakpointAdded: anAnnouncement [

	SessionService registerBreakpointAdd: anAnnouncement breakpoint node
]

{ #category : #updating }
BreakpointObserver >> updateSessionWithBreakpointHit: anAnnouncement [

	SessionService registerBreakpointHit: anAnnouncement breakpoint node
]

{ #category : #updating }
BreakpointObserver >> updateSessionWithBreakpointRemoved: anAnnouncement [

	SessionService registerBreakpointRemove: anAnnouncement breakpoint node
]

{ #category : #updating }
BreakpointObserver >> updateSessionWithVariableBreakpointAdded: anAnnouncement [

	| breakpoint |
	breakpoint := anAnnouncement breakpoint.

	breakpoint targetInstance ifNil: [ 
		anAnnouncement nodes do: [ :node | 
			SessionService registerWatchpointAdd: node ].
		anAnnouncement breakpoint targetVariableNames do: [ :item | 
			SessionService
				registerWatchpointVariableAdd: item
				targetClass: breakpoint targetClassOrMethod ].
		^ self ].

	anAnnouncement nodes do: [ :node | 
		SessionService
			registerWatchpointAdd: node
			instanceObject: breakpoint targetInstance ].
	breakpoint targetVariableNames do: [ :item | 
		SessionService
			registerWatchpointVariableAdd: item
			targetInstance: breakpoint targetInstance ]
]

{ #category : #updating }
BreakpointObserver >> updateSessionWithVariableBreakpointHit: anAnnouncement [

	| breakpoint |
	breakpoint := anAnnouncement breakpoint.

	breakpoint targetInstance ifNil: [ 
		SessionService
			registerWatchpointHit: anAnnouncement nodes first
			variableValue: anAnnouncement valueOrNil.
		^ self ].

	SessionService
		registerWatchpointHit: anAnnouncement nodes first
		variableValue: anAnnouncement valueOrNil
		targetInstance: breakpoint targetInstance
]

{ #category : #updating }
BreakpointObserver >> updateSessionWithVariableBreakpointRemoved: anAnnouncement [

	| breakpoint |
	breakpoint := anAnnouncement breakpoint.

	breakpoint targetInstance ifNil: [ 
		anAnnouncement nodes do: [ :node | 
			SessionService registerWatchpointRemove: node ].
		breakpoint targetVariableNames do: [ :item | 
			SessionService
				registerWatchpointVariableRemove: item
				targetClass: breakpoint targetClassOrMethod ].
		^ self ].

	anAnnouncement nodes do: [ :node | 
		SessionService
			registerWatchpointRemove: node
			instanceObject: breakpoint targetInstance ].
	breakpoint targetVariableNames do: [ :item | 
		SessionService
			registerWatchpointVariableRemove: item
			targetInstance: breakpoint targetInstance ]
]
