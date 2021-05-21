Class {
	#name : #ProcessorOfRestart,
	#superclass : #ProcessorOfStep,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfRestart >> initialize [ 
	self stepName: 'Restart'
]
