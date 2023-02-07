#!/usr/bin/env bash

if [ -z "${HOME}" ]
then
    echo "can't find HOME directory"
    exit 1
fi

home_prefix="${HOME}"

items_to_remove=".adobe/
.cache/QtWebEngine/Default/Cache
.cache/aria2
.cache/chromium
.cache/cool-retro-term
.cache/golangci-lint
.cache/mesa_shader_cache
.cache/midori
.cache/qtshadercache-x86_64-little_endian-lp64
.cache/sxiv
.cache/youtube-dl
.cache/yt-dlp
.compiz/sessions
.config/ghb/EncodeLogs
.config/transmission/resume
.config/transmission/torrents
.dvdcss/
.dvdisaster
.imibrowser
.ipython/profile_default/history.sqlite
.java/.userPrefs
.kde/share/apps/okular/
.kpcli-history
.lesshst
.local/share/RecentDocuments
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
.local/share/recently-used.xbel
.local/share/user-places.xbel
.local/share/vlc
.macromedia/
.mtpaint
.newsboat/cache.db
.newsboat/history.cmdline
.newsboat/history.search
.numptyphysics/
.recently-used
.sdcv_history
.units_history
.vim/.netrwhist
.viminfo
.w3m/cookie
.w3m/history
.wget-hsts
.xorgxrdp.10.log
.xorgxrdp.10.log.old
.xsession-errors
.xsession-errors.old"

for item in ${items_to_remove}
do
    if [ -e "${home_prefix}/${item}" ]
    then
        du -sh "${home_prefix}/${item}"
    fi
done

echo "press enter to delete, ctrl c to stop"
read -r

for item in ${items_to_remove}
do
    if [ -e "${home_prefix}/${item}" ]
    then
        echo "removing ${home_prefix:?}/${item:?}"
        rm -r -- "${home_prefix:?}/${item:?}"
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
