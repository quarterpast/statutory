LiveScript = require \LiveScript
{parser,uglify} = require \uglify-js

with require \browserify <| "./main.ls"
	@register \.ls LiveScript~compile

	@bundle!
	|> parser.parse
	|> uglify.ast_mangle
	|> uglify.ast_squeeze
	|> uglify.gen_code
	|> console.log