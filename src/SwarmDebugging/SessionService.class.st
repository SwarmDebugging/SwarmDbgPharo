Class {
	#name : #SessionService,
	#superclass : #Object,
	#classInstVars : [
		'currentSession',
		'swarmWindowData',
		'breakpointObserver'
	],
	#category : #'SwarmDebugging-SwarmCore-Service'
}

{ #category : #public }
SessionService class >> endCurrentSession [ 

	currentSession ifNil: [ ^self ].

	currentSession finished: DateAndTimeSwarm now.

	Repository save: currentSession.

	Breakpoint unregisterObserver: breakpointObserver.
	
	self reset.
	
]

{ #category : #public }
SessionService class >> getCurrentSession [
	^currentSession
]

{ #category : #public }
SessionService class >> getSwarmWindowData [
	^swarmWindowData
]

{ #category : #public }
SessionService class >> registerAlreadyAddedBreakpoints [

	currentSession ifNil: [ ^self ].
	
	Breakpoint all do: [ :breakpointItem | ProcessorOfBreakpointAlreadyAdded new process: breakpointItem node ].

]

{ #category : #public }
SessionService class >> registerBreakpointActive: nodeContext [

	currentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
"	ProcessorOfBreakpointAdd new process: nodeContext."
	self inform: 'TODO'.

]

{ #category : #public }
SessionService class >> registerBreakpointAdd: nodeContext [

	currentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
	ProcessorOfBreakpointAdd new process: nodeContext.

]

{ #category : #public }
SessionService class >> registerBreakpointRemove: nodeContext [

	currentSession ifNil: [ ^self ].

	nodeContext ifNil: [ ^self ].
	
"	ProcessorOfBreakpointAdd new process: nodeContext."
	self inform: 'TODO'.

]

{ #category : #public }
SessionService class >> registerNewSession [

	currentSession ifNotNil: [ self endCurrentSession ].

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

	self registerAlreadyAddedBreakpoints.
	
	breakpointObserver := BreakpointObserver new.
	
	Breakpoint registerObserver: breakpointObserver.
]

{ #category : #public }
SessionService class >> registerStepInto: context [
	
	self getCurrentSession ifNil: [ ^self ].
	
	ProcessorOfStepInto new process: context.
	
	(Delay forMilliseconds: 100) wait.
]

{ #category : #public }
SessionService class >> registerStepOver: context [
	
	self getCurrentSession ifNil: [ ^self ].
	
	ProcessorOfStepOver new process: context.
	
	(Delay forMilliseconds: 100) wait.
	

]

{ #category : #initialization }
SessionService class >> reset [
	<script: 'self reset'>
	currentSession := nil
]

{ #category : #public }
SessionService class >> setSwarmWindowData: windowProPerty [
	swarmWindowData := windowProPerty
]
