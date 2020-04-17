Class {
	#name : #ProcessorOfSession,
	#superclass : #Object,
	#instVars : [
		'stepName'
	],
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #process }
ProcessorOfSession >> processCodeFile: aContextProperty [

	| codeFile alreadyExist |

	aContextProperty filePath: (FileLocator imageDirectory / aContextProperty packageName / aContextProperty className, 'st') pathString.	

	codeFile := CodeFile new 
		id: UUID new printString;
		path: aContextProperty filePath;
		content: (ZnBase64Encoder new encode: (aContextProperty sourceCode) asByteArray);
		created: DateAndTimeSwarm now.
	
	alreadyExist := false.
	SessionService getCurrentSession codeFiles do: [ 
		:file | file path = (aContextProperty filePath) ifTrue: [ 
			alreadyExist := true 
			] 
		].
	
	alreadyExist ifFalse: [ 
			SessionService getCurrentSession codeFiles add: codeFile. 
		 ].
]

{ #category : #accessing }
ProcessorOfSession >> stepName [
	^stepName
]

{ #category : #accessing }
ProcessorOfSession >> stepName: aName [
	stepName := aName
]
