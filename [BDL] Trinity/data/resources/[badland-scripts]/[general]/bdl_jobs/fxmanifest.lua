fx_version 'adamant'
game 'gta5'

author 'ZIRAFLIX & E&G Team'
contact 'ZIRAFLIX: contato@ziraflix.com - Discord: discord.gg/ziraflix | E&G TEAM: badlandof@gmail.com - Discord: discord.gg/bABGBEX'
description 'Made by Ziraflix, optimized and configured by E&G Team'

ui_page 'minerman-foundry/nui/badland.html'

client_scripts {
	'@vrp/lib/utils.lua',
    'farmer/client/*.lua',
	'farmer-sell/client/*.lua',
    'garbageman/client/*.lua',
    'milkman/client/*.lua',
    'milkman-delivery/client/*.lua',
    'minerman/client/*.lua',
    'postman/client/*.lua',
    'postman-delivery/client/*.lua',
	'minerman-foundry/client/*.lua',
}

server_scripts {
	'@vrp/lib/utils.lua',
	'farmer/server.lua',
	'farmer-sell/server.lua',
    'garbageman/server.lua',
    'milkman/server.lua',
    'milkman-delivery/server.lua',
    'minerman/server.lua',
    'postman/server.lua',
    'postman-delivery/server.lua',
	'minerman-foundry/server.lua',
}

files {
	"minerman-foundry/nui/badland.html",
	"minerman-foundry/nui/badland.js",
	"minerman-foundry/nui/badland.css",
	"minerman-foundry/nui/img/*.png",
}