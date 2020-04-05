# SwarmDbgPharo
The Swarm Debugging Client for Pharo  
Instanciate a UI-less debugger on your execution, allowing you to manipulate and inspect it via scripting.  
In addition, it captures and sends debug data to the visualization.  
The API is on the SindarinDebugger class.  

## View
[Swarm View - v1](http://swarmserver.azurewebsites.net/)

## Install
```SmallTalk
Metacello new
    repository: 'github://SwarmDebugging/SwarmDbgPharo:master';
    baseline: 'SwarmDebugging';
    load.
```
    
## Usage
```SmallTalk
dbg := SwarmSindarinDebugger debug: [<your code>].
"Manipulate and inspect the debugged execution by sending messages to dbg"
dbg step; stepOver.
dbg context inspect.
...
```

### Sample sceneries for tests with examples of usages
```SmallTalk
Metacello new
    repository: 'github://eduardoafontana/Pharo-Classes-Sample:master';
    baseline: 'PharoClassesSample';
    load.
```

### Example of usage
```SmallTalk
dbg := SindarinDebuggerSwarm debug: [ ClassA new methodA1 ].
dbg stepOver.
dbg step.
dbg stepOver. "over ClassB new"
dbg stepOver. "over methodB1"
dbg stepOver. "over ClassB new "
dbg stepOver. "over methodB2"
dbg stepOver. "over ClassB new "
dbg stepOver. "over methodB3"
dbg stepOver. "over ClassB new "
dbg step. "into methodB1"
dbg stepOver. "over ClassC new"
dbg step. "into methodC1"
dbg stepOver. "return to ClassB"
dbg stepOver. "return to ClassA"
dbg stepOver. "return to root?"
dbg stepOver. "..."
```
