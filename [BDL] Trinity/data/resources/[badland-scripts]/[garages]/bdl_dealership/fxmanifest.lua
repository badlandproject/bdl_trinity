fx_version 'bodacious'
game 'gta5'

author 'RossiniJS for Badland Base'
contact 'https://github.com/rossiniJS ou discord.gg/bABGBEX'
version '1.0.0'

ui_page "nui/badland.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"ellie.lua"
}

files {
	"nui/badland.html",
	"nui/inicio.html",
	"nui/motos.html",
	"nui/import.html",
	"nui/possuidos.html",
	"nui/badland.js",
	"nui/badland.css",
	"nui/img/*.png"
}