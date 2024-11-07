shared_script '@narko/shared_fg-obfuscated.lua'
fx_version "bodacious"

games {"gta5"}
lua54 'yes'
author 'ReVeR'
description 'esx_ambulancejob'
version '2.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/*.lua',
}


exports {
	'isDead',
	'IsBlockWeapon'
}

shared_script '@ox_lib/init.lua'

dependency 'es_extended'