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