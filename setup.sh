#!/bin/sh

if test "X$1" == 'X-d'; then
    dry=echo
    shift
fi

if test "X$1" == "X"; then
    set -- symfiles
fi

linksfile="$1"

while read file; do
    for f in "$file" "$file-$(hostname)"; do
        # if the link source exists...
        if test -e "$f"; then
            d="${HOME}/.$(basename $f)"
            # and the link destination is either a symlink or nonexistant...
            if test ! -e "$d" -o -L "$d"; then
                $dry ln -sfn ".config/$f" "$d"
            else
                echo "Not linking $f"
            fi
        fi
    done
done < "$linksfile"
