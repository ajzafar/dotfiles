" Named after the bblean theme darksky by ratednc-17.com
" Written by Adnan Zafar, mostly based on the default Vim theme

if &t_Co >= 88 || has('gui_running')
    set background=dark
endif

hi clear

let g:colors_name = 'darksky'

hi Normal        guifg=#98a0aa  guibg=#1a1c20
hi NonText       guifg=#4d98a6  guibg=#0a0c10  gui=NONE
" hi String      guifg=#bdd5f2  guibg=#13326c
" hi Special     guifg=#ffa500  guibg=#14161a  gui=NONE
hi Comment       guifg=#467af2
hi ColorColumn   guifg=NONE     guibg=#591516
hi PreProc       guifg=#db5353
hi Constant      guifg=#e6171a
hi SpecialChar   guifg=#f03c7f
hi StatusLine    guifg=NONE     guibg=NONE     gui=reverse
hi StatusLineNC  guifg=#b9b9b9  guibg=#3e3e5e  gui=NONE
" hi Title       guifg=magenta
hi Type          guifg=#5cf55c  guibg=NONE     gui=NONE
hi Statement     guifg=#d9d957  guibg=NONE     gui=NONE
hi Identifier    guifg=#33c9c9
hi Error         guifg=#ffffff  guibg=#6e2e2e
hi Todo          guifg=#303030  guibg=#d0a060  gui=bold
hi LineNr        guifg=#8b8bcd  guibg=#16181c
hi IncSearch     guifg=#303030  guibg=#cd8b60  gui=bold
hi MatchParen    guifg=NONE     guibg=#095959
hi Folded        guifg=Cyan     guibg=#101216
hi TabLine       guifg=#b8c0ca  guibg=#3e3e5e  gui=NONE
hi TabLineSel    guifg=#b8c0ca  guibg=#0a0c10  gui=bold
hi TabLineFill   guifg=NONE     guibg=#3e3e5e  gui=NONE
hi Visual        guifg=fg       guibg=bg       gui=reverse
hi Pmenu         guifg=#c332c3  guibg=bg       gui=reverse
hi PmenuSel      guifg=#a9a9a9  guibg=bg       gui=reverse
hi PmenuSbar     guifg=#cecece  guibg=bg       gui=reverse
hi PmenuThumb    guifg=#676767  guibg=bg       gui=reverse

" Colors heavily influenced/taken from inkpot
hi DiffAdd       guifg=#cdd8e6  guibg=#012773  gui=NONE
hi DiffDelete    guifg=#cdd8e6  guibg=#6d3030  gui=NONE
hi DiffChange    guifg=#cdd8e6  guibg=#306d30  gui=NONE
hi DiffText      guifg=#cdd8e6  guibg=#4a2a4a  gui=NONE

hi! link VertSplit StatusLineNC
hi! link ErrorMsg Error
hi! link SpecialKey NonText
hi! link Delimiter SpecialChar
