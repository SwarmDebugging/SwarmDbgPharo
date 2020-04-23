Class {
	#name : #ActionSynchronizer,
	#superclass : #Object,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #waiting }
ActionSynchronizer class >> wait [
	(Delay forMilliseconds: 100) wait.
]
