" Some TeX settings.

""" General settings
setl shiftwidth=2
setl softtabstop=2

setl formatoptions+=c
setl formatoptions+=o
setl formatoptions+=r
let &l:flp = '\v\\%(item|prob)%([\[{]\ze.{-}[\]}])?\s*'

setl spell
let g:tex_comment_nospell = 1

""" Abbreviations
" taken from the Vim help, :h abbreviations
function! EatChar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

iab <buffer> lam lambda<C-R>=EatChar('\s')<CR>

""" :make
compiler tex

if ! ( filereadable('Makefile') || filereadable('makefile') )
    nnoremap <buffer> <F4> :make %:r<CR>
    let &mp = 'pdf' . &mp
else
    nnoremap <buffer> <F4> :make<CR>
endif

""" Plugin settings
if exists(':Tabularize')
    AddTabularPattern tex_table /&\|\\\\/
    nnoremap <buffer> <silent> <leader>tt :Tabularize tex_table<CR>
endif

if exists('g:loaded_surround')
    " vim-surround: q for `foo' and Q for ``foo''
    let b:surround_{char2nr('q')} = "`\r'"
    let b:surround_{char2nr('Q')} = "``\r''"
    " for sets
    let b:surround_{char2nr('s')} = "\\{ \r \\}"
endif

""
"" taken from godlygeek's vimrc. Pretty nice way to handle folding.
"" vim:fdm=expr
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
