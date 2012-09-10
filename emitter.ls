#emitter.ls
tick = if process? then that~next-tick else set-timeout _,0
class exports.Emitter
	queue = {}
	listeners = {}
	~>
		@guid = [1 to 10] |> map Math.random>>(* 26)>>floor |> concat-map [\a to \z]
		queue[@guid] = {}
		listeners[@guid] = {}
	emit: !(event,...args)->
		if listeners[@guid][event]?
			map ((fn)-> tick -> fn ...args), that
		else queue[@guid]@@[event].push args

	on: !(event,fn)->
		if queue[@guid]@@[event].length
			queue[@guid][event] |> map ((args)-> tick -> fn ...args)
		listeners[@guid]@@[event].push fn

if window? or module is require.main
	e = Emitter!
	e.emit \test "hello"
	e.on \test console~log