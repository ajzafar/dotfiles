# vim:ft=sh:fdm=marker:

ifrun() { # {{{
    if test "X$1" = "Xexec"; then
        exe=exec
        shift
    fi
    which $1 > /dev/null 2>&1 && $exe "$@";
} # }}}

# Environment {{{1
export URXVT_PERL_LIB="${XDG_CONFIG_HOME}/urxvt-perl"
export LIBVA_DRIVER_NAME="vdpau"

# Programs {{{1
ifrun xrdb -merge ${XDG_CONFIG_HOME}/Xresources
ifrun xsetroot -cursor_name Vienna3
ifrun xset mouse 1
ifrun xmodmap ${XDG_CONFIG_HOME}/Xmodmap
ifrun feh -z --bg-fill ${XDG_CONFIG_HOME}/backgrounds
ifrun pulseaudio --start

ifrun urxvtd -q -o -f
conkyrc=${XDG_CONFIG_HOME}/conkyrc-$(hostname)
[[ -f $conkyrc ]] && ifrun conky -d -c $conkyrc
[[ -f ${XDG_CONFIG_HOME}/sekrit/zipcode ]] && \
    ifrun xflux -z $(< ${XDG_CONFIG_HOME}/sekrit/zipcode )
[[ -d ~/music ]] && ifrun mpd

ifrun unclutter -idle 1.5 -jitter 5 -noevents &
ifrun dropbox &
ifrun mumble &
ifrun urxvt -name 'azscratch' -e tmux attach -t scratch &

# Synergy
synergy_host='ornata'
if test "X$(hostname)" == "X${synergy_host}"; then
    ifrun synergys
else
    ifrun synergyc $synergy_host
fi

# WM selection {{{1
case ${XSESSION:-awesome} in
    flux*)
        ifrun exec startfluxbox
        ;;
    openbox)
        ifrun exec openbox
        ;;
    xfce4)
        ifrun exec startxfce4
        ;;
    e16|enlightenment)
        ifrun exec e16 -f
        ;;
    twm)
        ifrun exec twm
        ;;
    awesome)
        ifrun exec awesome
        ;;
    i3)
        ifrun exec i3
        ;;
esac
# }}}

echo
echo '***********************'
echo
echo 'Pass the name of a valid WM/DE.'
echo
echo '***********************'

exit 1
