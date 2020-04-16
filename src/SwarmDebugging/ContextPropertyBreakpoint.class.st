Class {
	#name : #ContextPropertyBreakpoint,
	#superclass : #ContextProperty,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ContextPropertyBreakpoint >> extract: aContext [ 
	
	| namespaceWord |

	self className: aContext methodNode methodClass asString.
	self methodName: aContext methodNode selector asString.

	[ namespaceWord := (Smalltalk at: self className asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].

	self packageName: namespaceWord.
	self sourceCode: (aContext methodNode sourceCode asString) contents.
	self charStart: aContext start.
	self charEnd: aContext stop.
	self lineOfCode: (aContext methodNode source copyFrom: self charStart to: self charEnd) asString.
	self lineNumber: (aContext methodNode source copyFrom: 1 to: self charStart) asString lineCount.
		
	^self.
]
