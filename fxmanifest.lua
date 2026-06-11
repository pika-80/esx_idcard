fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'pika80'
discord 'https://discord.gg/hXrVb6q8N4'
description 'esx_idcard - Identity Card for ESX Framework'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
	'@es_extended/imports.lua',
	'config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

files {
	'html/index.html',
	'html/assets/css/*.css',
	'html/assets/js/*.js',
	'html/assets/fonts/roboto/*.woff',
	'html/assets/fonts/roboto/*.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/images/*.png'
}
