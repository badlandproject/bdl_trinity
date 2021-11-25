fx_version 'adamant'
game 'gta5'

author 'RossiniJS or Edu#0069 for Badland v3'
contact 'https://github.com/rossinijs or Edu#0069 on DiscordApp'
version '1.0.0'

ui_page 'nui/badland.html'

client_scripts {
    "@vrp/lib/utils.lua",
    "client-side/*.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "ellie.lua"
}

files {
    'nui/badland.html',
    'nui/badland.css',
    'nui/badland.js',

    'nui/media/*.png'
}