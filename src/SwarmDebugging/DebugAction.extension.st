Extension { #name : #DebugAction }

{ #category : #'*SwarmDebugging' }
DebugAction >> asGlamourAction [

	SessionService registerNewSessionFromDebugWindow: self currentContext.

	^ ((GLMGenericAction new) 
			action: [ self execute ]; 
			icon: self icon;
			title: self label;
			help: self help;
			showTitle;
			shortcut: (self keyText ifNotNil: [:aString | aString at: 1]);
			category: self category;
			yourself)
]
