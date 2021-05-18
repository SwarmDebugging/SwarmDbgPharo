Class {
	#name : #ActionSynchronizer,
	#superclass : #Object,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #waiting }
ActionSynchronizer class >> wait [

	Repository isRemoteLogMode ifFalse: [ ^ self ].
	100 milliSeconds wait
]
