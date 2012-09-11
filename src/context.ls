#context.ls
{EventEmitter} = require \events

exports.Context = (initial-state)->
	var state

	with (new EventEmitter) with {set-state:->@emit \state-change state := new &0 <<< context:this}
		@set-state initial-state

		~function dispatch methods
			for func,args of methods
				if (state)~[func]? then that ...args
				else throw TypeError "State #{state.display-name} has no method '#func'"

		dispatch import all this