Class {
	#name : #ContextPropertyStep,
	#superclass : #ContextProperty,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ContextPropertyStep >> extract: aContext [
	
	| typeWord namespaceWord lineOfCodeNode |
	
	typeWord := aContext methodClass asString.
	((typeWord indexOfSubCollection: ' class') asNumber > 1) ifTrue: [
			typeWord := typeWord copyFrom: 1 to: (typeWord indexOfSubCollection: ' class') - 1
		].

	lineOfCodeNode := (aContext method sourceNodeForPC: aContext pc).

	[ namespaceWord := (Smalltalk at: typeWord asSymbol) package name  ] 
		on: Exception
		do: [ namespaceWord := 'NamespaceNotFound' ].
	
	self packageName: namespaceWord.
	self className: typeWord.
	self methodName: aContext methodSelector asString.
	self sourceCode: (aContext sourceCode asString) contents.
	self charStart: lineOfCodeNode start.
	self charEnd: lineOfCodeNode stop.	
	self lineOfCode: ( lineOfCodeNode source copyFrom: self charStart to: self charEnd ) asString.
	self lineNumber: (lineOfCodeNode source copyFrom: 1 to: self charStart ) asString lineCount.

	^self.
		
]
