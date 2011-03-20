# dotfiles #

These are my dotfiles. I've included some less conventional files because I saw
no reason not to include them. Any sensitive information has either been
confined to the `sekrit` directory or simply not included. Machine-specific
configurations simply go into a `foo-$hostname` file.

I try to conform to the [XDG Base Directory standard][xdg-spec]. As such, I keep
this repo at `~/.config`, and use `setup.sh` to symlink files that need
symlinking. (The actual location doesn't matter, but `~/.config` makes sense to
me.) Some links are unnecessary but done anyway for convenience.

[xdg-spec]: http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
