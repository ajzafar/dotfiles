" Restore statusline
set stl<
" Alter b:undo_ftplugin accordingly
let b:undo_ftplugin = substitute(b:undo_ftplugin, '\Vset stl<', '', '')
