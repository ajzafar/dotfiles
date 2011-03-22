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
ifrun xrdb -merge ${XDG_CONFIG_HOME}/Xresources-$(hostname)
ifrun xsetroot -cursor_name Vienna3
# }}}

# Forking programs {{{
ifrun urxvtd -q -o -f
ifrun conky -d -c ${XDG_CONFIG_HOME}/conkyrc-$(hostname)
# }}}

# Backgrounded programs {{{
ifrun tilda &
ifrun unclutter -idle 1.5 -jitter 5 &
ifrun xscreensaver &
# }}}

# WM selection {{{
case $2 in
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
    awesome|*)
        ifrun exec awesome
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
