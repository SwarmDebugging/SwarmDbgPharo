Class {
	#name : #Repository,
	#superclass : #Object,
	#category : #'SwarmDebugging-DataLog'
}

{ #category : #action }
Repository class >> save: dataObject [

|jsonData|

jsonData := String streamContents: [ :stream | 
   (NeoJSONWriter on: stream)
      prettyPrint: true;
		mapInstVarsFor: SessionData;
		mapInstVarsFor: Event;
		mapInstVarsFor: CodeFile;
		mapInstVarsFor: PathNode; 
		mapInstVarsFor: BreakpointData;
      nextPut: (dataObject) ].

[ ZnClient new
   url: 'http://swarmserver.azurewebsites.net/api/session';
   entity: (ZnEntity
               with: jsonData 
               type: ZnMimeType applicationJson);
   post. ] schedule.
]
