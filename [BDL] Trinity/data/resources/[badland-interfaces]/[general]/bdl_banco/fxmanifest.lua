fx_version 'bodacious'
game 'gta5'

author 'Edu#0069 - E&G Vendas'
contact 'GitHub: https://github.com/badlandproject ou Discord: Edu#0069'
version '1.1.2'

ui_page('nui/badland.html')

client_script{
    '@vrp/lib/utils.lua',
    'client-side/*.lua'
}

server_script {
    '@vrp/lib/utils.lua',
	'ellie.lua'
}

files {
    'nui/badland.html',
    'nui/badland.css',
    'nui/badland.js',
    'nui/fonts/*.ttf',
}
