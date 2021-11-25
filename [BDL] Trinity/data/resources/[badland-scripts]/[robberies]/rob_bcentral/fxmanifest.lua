fx_version 'bodacious'
game 'gta5'

author 'unknown'
contact 'Edu#0069 or https://github.com/rossinijs'

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client-side/*.lua",
  "cfg/*.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}