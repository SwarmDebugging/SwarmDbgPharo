Extension { #name : #StDebugger }

{ #category : #'*SwarmDebugging' }
StDebugger class >> buildSwarmCommandsGroupWith: stDebuggerInstance forRoot: rootCommandGroup [

	<extensionCommands>
	| toolbarGroup |

	toolbarGroup := rootCommandGroup / 
		StDebuggerToolbarCommandTreeBuilder groupName / 
		StDebuggerToolbarCommandTreeBuilder basicNew executionControlGroupName.
		
	self transformDebuggerCommandNamed: StStepIntoCommand defaultName as: SwarmStepIntoCommand in: toolbarGroup entries.
	self transformDebuggerCommandNamed: StStepOverCommand defaultName as: SwarmStepOverCommand in: toolbarGroup entries.	
	self transformDebuggerCommandNamed: StStepThroughCommand defaultName as: SwarmStepThroughCommand in: toolbarGroup entries.		
	self transformDebuggerCommandNamed: StRestartCommand defaultName as: SwarmRestartCommand in: toolbarGroup entries.	
		
	
]

{ #category : #'*SwarmDebugging' }
StDebugger class >> transformDebuggerCommandNamed: aDebuggerCommandUniqueName as: aSwarmDebuggerCommand in: aDebuggerCommandGroup [	

	|originalCommand|
	originalCommand := aDebuggerCommandGroup detect:[:c| c decoratedCommand name = aDebuggerCommandUniqueName].		
	originalCommand decoratedCommand: (aSwarmDebuggerCommand forContext: originalCommand context).
	
]
