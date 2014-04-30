# vim:ft=sh:fdm=marker:

ifrun() { # {{{
    if test "X$1" = "Xexec"; then
        exe=exec
        shift
    fi
    which $1 > /dev/null 2>&1 && $exe "$@";
} # }}}

# Single run programs {{{
ifrun xrdb -merge ${XDG_CONFIG_HOME}/Xresources
ifrun xsetroot -cursor_name Vienna3
ifrun xset mouse 1
ifrun xmodmap ${XDG_CONFIG_HOME}/Xmodmap
ifrun feh -z --bg-fill ${XDG_CONFIG_HOME}/backgrounds
# }}}

# Forking programs {{{
ifrun urxvtd -q -o -f
conkyrc=${XDG_CONFIG_HOME}/conkyrc-$(hostname)
[[ -f $conkyrc ]] && ifrun conky -d -c $conkyrc
ifrun xflux -z $(< ${XDG_CONFIG_HOME}/sekrit/zipcode )
# }}}

# Backgrounded programs {{{
ifrun unclutter -idle 1.5 -jitter 5 -noevents &
ifrun dropbox &
# }}}

# Synergy {{{
synergy_host='mesabert'
if test "X$(hostname)" == "X${synergy_host}"; then
    ifrun synergys
else
    ifrun synergyc $synergy_host
fi
# }}}

# WM selection {{{
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
