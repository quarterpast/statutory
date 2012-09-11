#context.ls
{EventEmitter} = require \events

exports.Context = (initial-state)->
	var state

	with new EventEmitter import {set-state: compose do
		(new)
		(import context:this)
		(state:=)
		(->@emit \state-change it)
	}
		@set-state initial-state

		~function methodcall fn,args
			if (state)~[fn]? then that ...args
			else throw TypeError "State #{state.display-name} has no method '#fn'"

		~function dispatch obj => zip-with methodcall,(keys obj),(values obj)

		dispatch import all this