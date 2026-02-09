# How To Build @make  
  
## # Overview  
PBP is "Parts Based Programming".  
  
A Part is like a command line app in UNIX, but with fewer restrictions.  
###   
### Two Kinds of Parts  
* Leaf Part  
* Container Part  
### UNIX Command Line Restrictions  
### Port Restrictions  
- a UNIX command has one input port, called *stdin* and implemented internally as a file descriptor (FD)  
- a UNIX command has one output port, called *stdout* (an FD)  
- a UNIX command has one error output port, called *stderr* (and FD)  
  
### ### Routing Restrictions of UNIX Shells  
* UNIX commands can only be arranged in a left-to-right pipeline  
* feedback is not allowed  
* underlying FD structures make it possible to create feedback, but shell syntax does not encourage this  
### ### Fan-Out Restrictions  
* fan-out is not encouraged  
* once data coming in from a pipe has been consumed, other Parts cannot see the same data (or a copy of the data)  
* programmers must use the ‘tee’ command to create fan-out  
    * this is too cumbersome and breaks programmers’ “flow”  
    * the system should allow for this as a first-class operation, not as a second-class operation like that of inserting “tee”  
* “fan-out” means sending that the same data can be sent from one sender to multiple receivers  
* sending data from one sender to one receiver is “atomic” by virtue of the fact that fan-out is not allowed  
    * a more full implementation of fan-out must require that all receivers receive the data “at the same time”, without data from other senders being interleaved in time, for example if part A sends X to B and to C, while part Q sends Y to B and C, both B and C must see X before Y, or Y before X - the parts B and C cannot see different orderings of X and Y, e.g. B sees X,Y while C sees, Y,X (disallowed)  
        * this ordering guarantee makes it possible to reason about “time” and “ordering”, functional programming makes this impossible by ignoring “time” (it *is* possible to handle this kind of thing with functional programming, but, it is inconvenient and breaks programmers’ *flow *hence is not considered an easy choice hence is not affects the way that one thinks about solutions).  
###   
### ### Multi-Language  
### ### Layering  
  
This is but a model of programming. There are other models, but the above restrictions and UNIX's ubiquitousness discourage the use of other models  
  
## The PBP Model  
### Multiple-Language  
* use combinations of any and all languages available to build Parts, e.g. Python, Javascript, Prolog, bash, Odin, etc.  
### Routing is First Class  
* routing of dataflow determined by arrows drawn on a diagram  
* instead of left-to-right, top-to-bottom, CALL/block/RETURN strict sequencing which is hard-wired into popular PLs  
### Layering  
* add “direction” to connectors  
* down | across | up | through  
* allows combining Parts using containment/encapsulation instead of strict 2D sprawl  
* allows black-box approach  
## How To Build PBP Apps Using Currently Available Software  
* create app using combinations of multiple languages in its own directory, using shells to combine and pipeline components together (on command line(s) or whatever is convenient)  
    * the issue is not building the app, but how to combine such apps in a layered manner  
* create a shell script called @make  
    * script handles two use-cases  
        1. app is stand alone  
        2. app is “called” from another app  
* env var PBP  
    * path to stock PBP tools  
        * das2json  
        * t2t  
        * check-for-errors  
        * resetlog  
        * splitoutputs  
    * path to kernel code (kernel0d.py)  
* env var PBPWD  
    * path to working directory of sub-app  
* env var PBPCALLER  
    * path to working directory of parent app  
* env var PYTHONPATH  
    * needed by kernel0d.py  
    * must contain path to kernel0d.py so that main.py, etc. can import and use kernel API  
  
### Creating @make  
1. if 0 command line args -> set PBP, PBPWD, PBPCALLER, PYTHONPATH ; this is the top level, a stand alone app  
2. if there are 3 command line args -> $1 ==> PBPWD, callee’s (self’s) working dir, $2 ==> basename of drawing, $3 ==> PBPCALLER, caller’s (parent) working dir ; this is a sub-level app, a “black box” invoked by parent, must return the result to the parent  
3. else, error wrong invocation  
  
if this is a parent app {   
	call child’s @make with 3 args  
	use ‘m4’ to merge result from child with code for this parent app  
}  
  
use ${PBP}/das2json to convert drawing to JSON  
invoke python on main.py to process the JSON-ified drawing  
use ${PBP}/splitoutputs to chop outputs up into separate files  
if error file exists {  
	display the error file  
	quit with error status  
} else {  
	rename one of the files appropriately to be the result of running this (self) black box  
	quit with success status  
}  
  
  
