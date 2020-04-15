Class {
	#name : #DateAndTimeSwarm,
	#superclass : #DateAndTime,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #'instance creation' }
DateAndTimeSwarm class >> now [ 
	"The Swarm database expects timestamps to be strings with this format: MM/DD/YYYY HH:mm:ss:nnnnnnnnn
	n = nanosecond"
	| d s |
	
	d := super now.
	s := ReadWriteStream on: (String new).
	
	s nextPutAll: (d month printPaddedWith: $0 to: 2);
	nextPutAll: '/';
	nextPutAll: (d dayOfMonth printPaddedWith: $0 to: 2);
	nextPutAll: '/';
	nextPutAll: (d year printPaddedWith: $0 to: 4);
	nextPutAll: ' ';
	nextPutAll: (d hour24 printPaddedWith: $0 to: 2);
	nextPutAll: ':';
	nextPutAll: (d minute printPaddedWith: $0 to: 2);
	nextPutAll: ':';
	nextPutAll: (d second printPaddedWith: $0 to: 2);
	nextPutAll: '.';
	nextPutAll: (d nanoSecond printPaddedWith: $0 to: 9).
	
	^ s contents.
]
