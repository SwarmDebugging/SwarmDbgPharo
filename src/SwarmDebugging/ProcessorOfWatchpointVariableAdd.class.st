Class {
	#name : #ProcessorOfWatchpointVariableAdd,
	#superclass : #ProcessorOfBreakpoint,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #'as yet unclassified' }
ProcessorOfWatchpointVariableAdd >> extract: aVariable class: aClass [

	| namespaceWord |

	self className: aClass asString.
	self methodName: nil.

	[ namespaceWord := (Smalltalk at: self className asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].

	self packageName: namespaceWord.
	self sourceCode: nil.
	self charStart: nil.
	self charEnd: nil.
	self lineOfCode: nil.
	self lineNumber: nil.
	
	self variableName: aVariable asString.
	
]

{ #category : #initialization }
ProcessorOfWatchpointVariableAdd >> initialize [ 
	self stepName: 'WatchpointVariableAdd'.
]

{ #category : #'as yet unclassified' }
ProcessorOfWatchpointVariableAdd >> process: aVariable class: aClass [
 
	self extract: aVariable class: aClass.

	self processEvent.
	
	Repository save: SessionService getCurrentSession.
]
