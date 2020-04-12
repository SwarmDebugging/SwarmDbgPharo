Class {
	#name : #DateAndTimeSwarm,
	#superclass : #DateAndTime,
	#category : #'SwarmDebugging-DataModel'
}

{ #category : #'instance creation' }
DateAndTimeSwarm class >> now [ 
	| d s n |
	
	d := super now.
	n := d nanoSecond asString padLeftTo: 9 with: $0.

	s := d month asString, '/',
	d dayOfMonth asString, '/', 
	d year asString, ' ', 
	d hour24 asString, ':', 
	d minute asString, ':', 
	d second asString, '.',
	n asString.	
	
	Transcript show: d; cr; show: s; cr.
	
	^s.
]
