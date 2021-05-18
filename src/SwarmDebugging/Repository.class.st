Class {
	#name : #Repository,
	#superclass : #Object,
	#classInstVars : [
		'monitor',
		'logDir',
		'logMode'
	],
	#category : #'SwarmDebugging-Repository'
}

{ #category : #'mutual exclusion' }
Repository class >> critical: aBlock [
	self monitor critical: aBlock
]

{ #category : #logging }
Repository class >> defaultLogMode [
	 ^self localLogMode
]

{ #category : #testing }
Repository class >> isRemoteLogMode [

	^ self logMode = self remoteLogMode
]

{ #category : #logging }
Repository class >> localLog: aString [
	|str|
	str := self stream.
	str setToEnd.
	str crlf.
	str nextPutAll: aString.	
	str close
]

{ #category : #logging }
Repository class >> localLogMode [
	 ^#local
]

{ #category : #logging }
Repository class >> logDir [

	^ logDir ifNil: [ 
		  logDir := 'swarm' asFileReference.
		  logDir ensureCreateDirectory ]
]

{ #category : #logging }
Repository class >> logFileReference [
	| fname fr |
	fname := SessionManager default currentSession id asString.
	fr := self logDir / fname.
	fr ensureCreateFile.
	^ fr
]

{ #category : #logging }
Repository class >> logMode [

	^ logMode ifNil: [ self defaultLogMode ]
]

{ #category : #accessing }
Repository class >> monitor [
	^monitor ifNil:[monitor := Monitor new]
]

{ #category : #logging }
Repository class >> remoteLog: aString [

	[ 
	ZnClient new
		url: 'http://swarmserver.azurewebsites.net/api/session';
		entity: (ZnEntity with: aString type: ZnMimeType applicationJson);
		post ] schedule
]

{ #category : #logging }
Repository class >> remoteLogMode [
	 ^#remote
]

{ #category : #action }
Repository class >> save: dataObject [

	| jsonData |
	jsonData := String streamContents: [ :stream | 
		            (NeoJSONWriter on: stream)
			            prettyPrint: true;
			            mapInstVarsFor: SessionData;
			            mapInstVarsFor: Event;
			            mapInstVarsFor: CodeFile;
			            mapInstVarsFor: PathNode;
			            mapInstVarsFor: BreakpointData;
			            nextPut: dataObject ].

	self isRemoteLogMode ifTrue: [ 
		self remoteLog: jsonData.
		^ self ].
	self localLog: jsonData
]

{ #category : #logging }
Repository class >> setFileLogMode [
	 logMode := #file
]

{ #category : #logging }
Repository class >> setRemoteLogMode [
	 logMode := self remoteLogMode
]

{ #category : #logging }
Repository class >> stream [
	^ self logFileReference writeStream
]
