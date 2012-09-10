{Emitter} = require "./emitter"

Machine = (...states)->
	#@state = states.0
	states = map (new)>>(import machine:this), states
	with (Emitter! import set-state: (@state=)>>(->@emit \state-change it))
		dispatch = (obj)~>
			zip-with ([fn,args])~>
				console.log this.state
				#states |> find (instanceof @state) |> (.[fn] ...args)
			,(keys obj),(values obj)
		dispatch <<<< this

class State
	extended(sub)= this@@subclasses.push sub

class State1 extends State
	test: ->say \hello

if window? or module is require.main
	m = Machine State1
	m.set-state State1
	console.log (new State1 instanceof State1)
	m test:[]
