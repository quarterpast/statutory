LiveScript = require \LiveScript
{parser,uglify} = require \uglify-js
fs = require \fs

with require \browserify <| "../src/main.ls"
	@register \.ls LiveScript~compile
	@bundle!
	|> parser.parse
	|> uglify.ast_mangle
	|> uglify.ast_squeeze
	|> uglify.gen_code
	|> fs.write-file "../dist/app.min.js",_,->if it? then throw it