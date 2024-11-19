--[[

    💬 Export from AFU Squad
    🐌 @Copyright Danyouknowme x Txrxx x Hex

    ☕ Thanks For Coffee Tips  💳 Buy token at awayfromus.dev
    
]]

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'AFU Squad'
description 'A common library for AFU Squad resources.'
version '1.0.0'

client_scripts {
    "common/*.lua",
    "replicate_data/client.lua",
    "synchronize/client.lua",
    "shared.lua",
    "test/client.lua"
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "common/*.lua",
    "replicate_data/server.lua",
    "synchronize/server.lua",
    "shared.lua",
    "test/server.lua"
}