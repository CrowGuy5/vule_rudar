fx_version 'adamant'
game 'gta5'



client_script {
 '__src/apokalipsa_cl.lua',
 'config.lua'
}

server_script {
'__src/apokalipsa_sv.lua'
}

lua54        'yes'
shared_scripts {
    '@ox_lib/init.lua'
}