statutory
=======
```coffeescript
class state-one
	action: ->
		say it
		@context.set-state state-two
class state-two
	count: 0
	action: ->
		say it
		if ++@count is 2 then @context.set-state state-one

{Context} = require \statutory

ctx = Context state-one
[1 to 10] |> each ->ctx action:['hello']

#=> hello HELLO HELLO hello HELLO HELLO &c.
```