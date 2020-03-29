Extension { #name : #DebugSession }

{ #category : #'*SwarmDebugging' }
DebugSession >> stepInto: aContext [
	"Send the selected message in selectedContext, and take control in 
	the method invoked to allow further step or send."

	(self isContextPostMortem: aContext) ifTrue: [^ self].

	SessionService registerStepInto: (self stepToFirstInterestingBytecodeIn: interruptedProcess).

	interruptedProcess step: aContext.
	self updateContextTo: (self stepToFirstInterestingBytecodeIn: interruptedProcess).
	
	self triggerEvent: #stepInto
]

{ #category : #'*SwarmDebugging' }
DebugSession >> stepOver: aContext [
	"Send the selected message in selectedContext, and regain control 
	after the invoked method returns."
	
	| newContext |
	
	(self isContextPostMortem: aContext) ifTrue: [^ self].
	
	SessionService registerStepOver: (self stepToFirstInterestingBytecodeIn: interruptedProcess).
	
	newContext := interruptedProcess completeStep: aContext.
	self updateContextTo:  
		(newContext == aContext
			ifTrue: [ (self stepToFirstInterestingBytecodeIn: interruptedProcess) ]
			ifFalse: [ newContext ]).

	self triggerEvent: #stepOver 
]

{ #category : #'*SwarmDebugging' }
DebugSession >> stepThrough: aContext [
	"Send messages until you return to selectedContext.
	 Used to step into a block in the method."
	
	(self isContextPostMortem: aContext) ifTrue: [^ self].
	
	SessionService registerStepOver: (self stepToFirstInterestingBytecodeIn: interruptedProcess).
	
	interruptedProcess stepToHome: aContext.
	self updateContextTo: (self stepToFirstInterestingBytecodeIn: interruptedProcess).
			
	self triggerEvent: #stepThrough 
]

{ #category : #'*SwarmDebugging' }
DebugSession >> terminate [
	"Action that needs to be executed after the window containing this debug session is closed, 
	in order to terminate the right process."

	SessionService endCurrentSession.
	
	self interruptedProcess 
		ifNotNil: [ 			
			"Assume the user closed the debugger. Simply kill the interrupted process."
			self interruptedProcess terminate.
			self clear.
			Smalltalk installLowSpaceWatcher.  "restart low space handler" ]
		ifNil: [ 
			"Assume the interrupted process was resumed."
			"Kill the active process if the error was in the UI as there should be only one UI process."
			self isAboutUIProcess
				ifTrue: [Processor terminateActive] ]
	
]
