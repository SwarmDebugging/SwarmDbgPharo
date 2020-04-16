Class {
	#name : #ProcessorOfStepInto,
	#superclass : #ProcessorOfStep,
	#category : #'SwarmDebugging-SwarmCore-Domain'
}

{ #category : #initialization }
ProcessorOfStepInto >> initialize [ 
	self stepName: 'StepInto'
]
