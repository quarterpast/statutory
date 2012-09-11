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

		~function dispatch methods
			for func,args of methods
				if (state)~[func]? then that ...args
				else throw TypeError "State #{state.display-name} has no method '#func'"

		dispatch import all this