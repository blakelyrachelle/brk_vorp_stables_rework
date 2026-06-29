fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

author 'VORP @CrimsonFreak / BRK @BlakelyRachelle'
original_resource 'VORP Stables by VORPCORE / CrimsonFreak'
version '1.0.0'
name 'BRK VORP Stables Rework'
description 'Free community rework of VORP Stables with improved vendor inventories, horse categories, tack storage/loadouts, and stable menu fixes.'
repository 'https://github.com/blakelyrachelle/brk_vorp_stables_rework'
brk_release_notice 'Free community release. Do not rename, repackage, or resell as original work.'

shared_scripts {
    'keys.lua',
    'events.lua',
    'data.lua',
    'languages.lua',
    'deathReasons.lua',
    'config.lua',
}

client_scripts {
    '@vorp_core/client/dataview.lua',
    'Client/*.lua',
}

server_scripts {
    'Server/main.lua',
}

files {
    'UI/dist/assets/*.js',
    'UI/src/Metadata.js',
    'UI/dist/assets/*.css',
    'UI/dist/index.html',
}

ui_page 'UI/dist/index.html'
