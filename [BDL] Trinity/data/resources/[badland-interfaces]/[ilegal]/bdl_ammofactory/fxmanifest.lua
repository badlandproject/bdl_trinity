fx_version 'adamant'
game 'gta5'

author 'rossiniJS for Badland Project'
contact 'https://discord.gg/bABGBEX or https://github.com/badlandproject'
version '1.0.0'

ui_page 'nui/badland.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'client-side/*.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'ellie.lua'
}

files {
	'nui/badland.html',
	'nui/badland.css',
	'nui/badland.js',
	'nui/img/*.png'
}