#!/usr/bin/env bash

if [ -z "$HOME" ]
then
    echo "can't find HOME directory"
    exit 1
fi

home_prefix="$HOME"

items_to_remove=".adobe/
.cache/chromium
.cache/cool-retro-term
.cache/mesa_shader_cache
.cache/qtshadercache-x86_64-little_endian-lp64
.compiz/sessions
.dvdcss/
.java/.userPrefs
.kde/share/apps/okular/
.lesshst
.local/share/baloo
.local/share/kactivitymanagerd
.local/share/kate
.local/share/kcookiejar
.local/share/kded5/keyboard
.local/share/klipper
.local/share/knewstuff3
.local/share/konsole
.local/share/kscreen
.local/share/ksysguard
.local/share/RecentDocuments
.local/share/recently-used.xbel
.local/share/user-places.xbel
.local/share/vlc
.macromedia/
.mtpaint
.numptyphysics/
.recently-used
.sdcv_history
.units_history
.vim/.netrwhist
.viminfo
.w3m/cookie
.w3m/history
.wget-hsts
.xsession-errors
.xsession-errors.old"

for item in $items_to_remove
do
    if [ -e "${home_prefix}/${item}" ]
    then
        du -sh "${home_prefix}/${item}"
    fi
done

echo "press enter to delete, ctrl c to stop"
read -r

for item in $items_to_remove
do
    if [ -e "${home_prefix}/${item}" ]
    then
        rm -rv -- "${home_prefix:?}/${item:?}"
    fi
done

echo "Home Directory Cleanup"

echo "Thumbnails Cleanup"
find "${home_prefix}/.thumbnails" -type f -print -delete
find "${home_prefix}/.cache/thumbnails" -type f -print -delete
find "${home_prefix}/.cache/sxiv" -type f -print -delete

echo "Golang Cache Cleanup"
go clean -cache

exit 0
