#context.ls
{Emitter} = require "./emitter"

throw-unless(fn,msg,val)= unless fn val then throw TypeError msg else val

Context = (...states)->
	var state

	with Emitter! import {set-state: compose do
		throw-unless (in states),"Not a valid state"
		(new)
		(import context:this)
		(state:=)
		(->@emit \state-change it)
	}

		@set-state states.0
		~function methodcall fn,args
			if (state)~[fn]? then that ...args
			else throw TypeError "State #{state.display-name} has no method '#fn'"
		~function dispatch obj => zip-with methodcall,(keys obj),(values obj)
		dispatch <<<< this

class State
	@extended(sub)= this@@subclasses.push sub

class State1 extends State
	test: ->
		say it
		@context.set-state State2
class State2 extends State
	count: 0
	test: ->
		say it.to-upper-case!
		if ++@count is 2 then @context.set-state State1

if window? or module is require.main
	m = Context ...State.subclasses
	m.set-state State1
	[1 to 10] |> each ->m test:[\hello]