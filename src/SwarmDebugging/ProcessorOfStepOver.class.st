Class {
	#name : #ProcessorOfStepOver,
	#superclass : #ProcessorOfStep,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfStepOver >> initialize [ 
	self stepName: 'StepOver'
]
