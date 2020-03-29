Extension { #name : #SindarinDebugger }

{ #category : #'*SwarmDebugging' }
SindarinDebugger class >> debugSwarm: aBlock [
	
	SessionService registerNewSession.
	
	^ self new debug: aBlock

]

{ #category : #'*SwarmDebugging' }
SindarinDebugger >> stepOverSwarm [
	| startContext |
	startContext := self context.
	
	SessionService registerStepOver: self context.	
	self step.
	
	[ self context == startContext
		or: [ startContext sender isNil
				or: [ startContext hasSender: self context ] ] ]
		whileFalse: [ 
			SessionService registerStepOver: self context.
			self step ]
]

{ #category : #'*SwarmDebugging' }
SindarinDebugger >> stepSwarm [
	SessionService registerStepInto: self context. 
	self step.
]

{ #category : #'*SwarmDebugging' }
SindarinDebugger >> stepThroughSwarm [
	SessionService registerStepOver: self context. 
	self stepThrough.
]
