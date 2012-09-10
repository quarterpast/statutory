{Emitter} = require "./emitter"

Machine = (...states)->
	state = states.0
	with (Emitter! import set-state: (state:=)>>(->@emit \state-change it))
		states = map (new)>>(import machine:this), states
		dispatch = (obj)~>
			zip-with ([fn,args])~>
				states |> find (instanceof state) |> console.log
			,(keys obj),(values obj)
		dispatch <<<< this

class State
	@extended(sub)= this@@subclasses.push sub

class State1 extends State
	test: ->say \hello

if window? or module is require.main
	m = Machine ...State.subclasses
	m.set-state State1
	console.log (new State1 instanceof State1)
	m test:[]
