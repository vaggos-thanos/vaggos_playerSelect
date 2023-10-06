fx_version 'cerulean'

game 'gta5'
author 'vaggos_Dev'
description ''

client_scripts {
    'config.lua',
    'client/*.lua',
    '@es_extended/imports.lua',
}

ui_page {
    'html/index.html', 
}

files {
    'html/index.html',
    'html/app.js', 
    'html/style.css'
}

shared_script '@ox_lib/init.lua'

dependencies {
    "MugShotBase64",
    "ox_lib"
}

lua54 'yes'