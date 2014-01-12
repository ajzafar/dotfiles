" Named after the bblean theme darksky by ratednc-17.com
" Written by Adnan Zafar, mostly based on the default Vim theme

if &t_Co >= 88 || has('gui_running')
    set background=dark
endif

hi clear

let g:colors_name = 'darksky'

hi Normal        guifg=#98a0aa  guibg=#1a1c20
hi Visual        guifg=fg       guibg=bg       gui=reverse

hi LineNr        guifg=#8b8bcd  guibg=#0a0c10
hi CursorLineNr  guifg=#6060e5  guibg=#0a0c10
hi NonText       guifg=#4d98a6  guibg=#0a0c10  gui=NONE
hi! link SpecialKey NonText

hi Error         guifg=#ffffff  guibg=#6e2e2e
hi! link ErrorMsg Error
hi IncSearch     guifg=#303030  guibg=#cd8b60  gui=bold
hi MatchParen    guifg=#303030  guibg=#cd8b60

hi StatusLine    guifg=NONE     guibg=NONE     gui=reverse
hi StatusLineNC  guifg=#b9b9b9  guibg=#292936  gui=NONE
hi! link VertSplit StatusLineNC

hi Folded        guifg=Cyan     guibg=#101216
hi! link FoldColumn Folded

hi Comment       guifg=#467af2
hi Constant      guifg=#e6171a
hi! link Delimiter SpecialChar
hi Identifier    guifg=#33c9c9
hi PreProc       guifg=#db5353
hi SpecialChar   guifg=#f03c7f
hi Statement     guifg=#d9d957  guibg=NONE     gui=NONE
hi Todo          guifg=#303030  guibg=#d0a060  gui=bold
hi Type          guifg=#5cf55c  guibg=NONE     gui=NONE

hi ColorColumn   guifg=NONE     guibg=#591516

hi Pmenu         guifg=#c332c3  guibg=bg       gui=reverse
hi PmenuSel      guifg=#a9a9a9  guibg=bg       gui=reverse
hi PmenuSbar     guifg=#cecece  guibg=bg       gui=reverse
hi PmenuThumb    guifg=#676767  guibg=bg       gui=reverse

" Colors heavily influenced/taken from inkpot
hi DiffAdd       guifg=#cdd8e6  guibg=#012773  gui=NONE
hi DiffChange    guifg=#cdd8e6  guibg=#306d30  gui=NONE
hi DiffDelete    guifg=#cdd8e6  guibg=#6d3030  gui=NONE
hi DiffText      guifg=#cdd8e6  guibg=#4a2a4a  gui=NONE

hi TabLine       guifg=#b8c0ca  guibg=#292936  gui=NONE
hi TabLineFill   guifg=NONE     guibg=#292936  gui=NONE
hi TabLineSel    guifg=#b8c0ca  guibg=#0a0c10  gui=bold
