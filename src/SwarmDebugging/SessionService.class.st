Class {
	#name : #SessionService,
	#superclass : #Object,
	#classInstVars : [
		'currentSession',
		'swarmWindowData',
		'breakpointObserver',
		'developerID'
	],
	#category : #'SwarmDebugging-SwarmCore-Service'
}

{ #category : #accessing }
SessionService class >> developerID [
	 ^developerID ifNil:[developerID := UUID new]
]

{ #category : #'session management' }
SessionService class >> endCurrentSession [ 

	self getCurrentSession ifNil: [ ^self ].

	currentSession finished: DateAndTimeSwarm now.
	Repository save: currentSession.
	
	self reset
	
]

{ #category : #accessing }
SessionService class >> getCurrentSession [
	^currentSession
]

{ #category : #accessing }
SessionService class >> getSwarmWindowData [
	^swarmWindowData
]

{ #category : #registering }
SessionService class >> registerAlreadyAddedBreakpoints [

	self getCurrentSession ifNil: [ ^ self ].

	Breakpoint all do: [ :breakpointItem | 
		self registerExistingBreakpoint: breakpointItem.

		ActionSynchronizer wait ]
]

{ #category : #registering }
SessionService class >> registerBreakpointActive: nodeContext [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfBreakpointActive new process: nodeContext.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerBreakpointAdd: nodeContext [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfBreakpointAdd new process: nodeContext.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerBreakpointHit: nodeContext [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfBreakpointHit new process: nodeContext.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerBreakpointRemove: nodeContext [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfBreakpointRemove new process: nodeContext.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerDebuggerOpening: context [
	
	self getCurrentSession ifNil: [ ^self ].
	
	ProcessorOfDebuggerOpening new process: context.
	
	ActionSynchronizer wait.
]

{ #category : #registering }
SessionService class >> registerExistingBreakpoint: aBreakpoint [

	aBreakpoint isVariableBreakpoint ifFalse: [ 
		ProcessorOfBreakpointAlreadyAdded new process: aBreakpoint node.
		^ self ].

	aBreakpoint targetInstance ifNil: [ 
		aBreakpoint link nodes do: [ :node | 
			ProcessorOfWatchpointAlreadyAdded new process: node.
			ActionSynchronizer wait ].
		aBreakpoint targetVariableNames do: [ :item | 
			ProcessorOfWatchpointVariableAdd new
				process: item
				class: aBreakpoint targetClassOrMethod ].
		^ self ].

	aBreakpoint link nodes do: [ :node | 
		ProcessorOfWatchpointObjectAlreadyAdd new
			process: node
			instanceObject: aBreakpoint targetInstance ].
	aBreakpoint targetVariableNames do: [ :item | 
		ProcessorOfWatchpointObjectVariableAdd new
			process: item
			instance: aBreakpoint targetInstance ]
]

{ #category : #'session management' }
SessionService class >> registerNewSession [

	self getCurrentSession ifNotNil: [ self endCurrentSession ].

	swarmWindowData ifNil:[ swarmWindowData := 
		WindowProperty new 
			projectName: 'Pharo Project Sample'; 
			developerName:'I am a Developer';
			taskName: 'This is my current task';
			taskAction: 'SearchingBug';
			taskDescription: ''
		].

	currentSession := 
		SessionData new 
			id: UUID new printString; 
			description: 'Swarm on Pharo';			
			started: DateAndTimeSwarm now;
			developerName: swarmWindowData developerName;
			taskName: swarmWindowData taskName;
			taskAction: swarmWindowData taskAction;
			taskDescription: swarmWindowData taskDescription;
			taskCreated: nil; "revisar depois"
			taskTotalSessionTime: '00:00:00.0000000';
			projectName: swarmWindowData projectName;
			breakpoints: OrderedCollection new;
			codeFiles: OrderedCollection new;
			events: OrderedCollection new;
			pathNodes: OrderedCollection new.

	Repository save: currentSession.

	breakpointObserver := BreakpointObserver new.
	self registerAlreadyAddedBreakpoints.

]

{ #category : #registering }
SessionService class >> registerRestart: context [
	
	self getCurrentSession ifNil: [ ^self ].
	
	ProcessorOfRestart new process: context.
	
	ActionSynchronizer wait.
]

{ #category : #registering }
SessionService class >> registerStepInto: context [
	
	self getCurrentSession ifNil: [ ^self ].
	
	ProcessorOfStepInto new process: context.
	
	ActionSynchronizer wait.
]

{ #category : #registering }
SessionService class >> registerStepOver: context [
	
	self getCurrentSession ifNil: [ ^self ].
	
	ProcessorOfStepOver new process: context.
	
	ActionSynchronizer wait.
	

]

{ #category : #registering }
SessionService class >> registerWatchpointAdd: nodeContext [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfWatchpointAdd new process: nodeContext.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointAdd: nodeContext instanceObject: instanceObject [

	self getCurrentSession ifNil: [ ^self ].
	
	nodeContext ifNil: [ ^self ].
	instanceObject ifNil: [ ^self ].
	
	ProcessorOfWatchpointObjectAdd new process: nodeContext instanceObject: instanceObject.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointHit: nodeContext variableValue: aValue [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfWatchpointHit new process: nodeContext variableValue: aValue.
	
	ActionSynchronizer wait.
]

{ #category : #registering }
SessionService class >> registerWatchpointHit: nodeContext variableValue: aValue targetInstance: aObject [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	aObject ifNil: [ ^self ].
	
	ProcessorOfWatchpointObjectHit new process: nodeContext variableValue: aValue instance: aObject.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointRemove: nodeContext [

	self getCurrentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfWatchpointRemove new process: nodeContext.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointRemove: nodeContext instanceObject: instanceObject [

	self getCurrentSession ifNil: [ ^self ].
	
	nodeContext ifNil: [ ^self ].
	instanceObject ifNil: [ ^self ].
	
	ProcessorOfWatchpointObjectRemove new process: nodeContext instanceObject: instanceObject.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointVariableAdd: aVariable targetClass: aClass [

	self getCurrentSession ifNil: [ ^self ].

	aVariable ifNil: [ ^self ].
	aClass ifNil: [ ^self ].
	
	ProcessorOfWatchpointVariableAdd new process: aVariable class: aClass.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointVariableAdd: aVariable targetInstance: aObject [

	self getCurrentSession ifNil: [ ^self ].

	aVariable ifNil: [ ^self ].
	aObject ifNil: [ ^self ].
	
	ProcessorOfWatchpointObjectVariableAdd new process: aVariable instance: aObject.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointVariableRemove: aVariable targetClass: aClass [

	self getCurrentSession ifNil: [ ^self ].

	aVariable ifNil: [ ^self ].
	aClass ifNil: [ ^self ].
	
	ProcessorOfWatchpointVariableRemove new process: aVariable class: aClass.
	
	ActionSynchronizer wait.

]

{ #category : #registering }
SessionService class >> registerWatchpointVariableRemove: aVariable targetInstance: aObject [

	self getCurrentSession ifNil: [ ^self ].

	aVariable ifNil: [ ^self ].
	aObject ifNil: [ ^self ].
	
	ProcessorOfWatchpointObjectVariableRemove new process: aVariable instance: aObject.
	
	ActionSynchronizer wait.

]

{ #category : #'session management' }
SessionService class >> reset [
	<script: 'self reset'>
	currentSession := nil.
	breakpointObserver := nil.
	Smalltalk garbageCollect 
]

{ #category : #accessing }
SessionService class >> setSwarmWindowData: windowProPerty [
	swarmWindowData := windowProPerty
]
