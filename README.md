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
load
```
    
## Usage
```SmallTalk
dbg := SwarmSindarinDebugger debugSwarm: [<your code>].
"Manipulate and inspect the debugged execution by sending messages to dbg"
dbg step; stepOver.
dbg context inspect.
...
```
