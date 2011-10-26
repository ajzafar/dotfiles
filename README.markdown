# `dotfiles` #

These are my `dotfiles`. I've included some less conventional files because
I saw no reason not to include them. Any sensitive information has either been
confined to the `sekrit` directory or not included. Machine-specific
configurations are placed into a `foo-$hostname` file.

I try to conform to the [XDG Base Directory standard][xdg-spec]. As such, I keep
this repo at `~/.config` and use `setup.sh` to symlink files as needed. (The
actual location doesn't matter, but `~/.config` makes sense to me.) Some links
are unnecessary but created for convenience.

## Copying ##

Everything in this repository written/created by me are in the public domain.
Anything not written by me will have information either in the source or in
a `README` in the same directory.

[xdg-spec]: http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
