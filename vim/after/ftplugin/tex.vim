"" Vim settings {{{
setl shiftwidth=2
setl softtabstop=2

setl formatoptions+=c
setl formatoptions+=o
setl formatoptions+=r

setl commentstring=%%%s

setl spell
let g:tex_comment_nospell = 1
"" }}}

" Abbreviations {{{
" taken from the Vim help, :h abbreviations
function! EatChar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

iab <buffer> lam lambda<C-R>=EatChar('\s')<CR>
" }}}

compiler tex

""" :make settings
" Use vimrc defaults if a Makefile exists
if ! ( filereadable('Makefile') || filereadable('makefile') )
    nnoremap <buffer> <F4> :make %:r<CR>
    let &mp = 'pdf' . &mp
else
    nnoremap <buffer> <F4> :make<CR>
endif

" Tabular {{{
if exists('g:tabular_loaded')
    let b:tab_form = 'l1'
    " This basically replaces the ending \\ with a @, tabularizes it, then
    " replaces the @ with the original \\
    AddTabularPipeline! tex_table / & /
                \ map(a:lines, "substitute(v:val, '\\\\\\\\', '@', '')") |
                \ tabular#TabularizeStrings(a:lines, '[&@]', b:tab_form) |
                \ map(a:lines, "substitute(v:val, '@', '\\\\\\\\', '')")
    nnoremap <buffer> <silent> <leader>tt :Tabularize tex_table<CR>
    nnoremap <buffer> <expr> <silent> <leader>tn ":let b:tab_form = '" .
                \ input("New tabular format (count field separators): ") . "'<CR>"
endif
" }}}

if exists('g:loaded_surround')
    " vim-surround: q for `foo' and Q for ``foo''
    let b:surround_{char2nr('q')} = "`\r'"
    let b:surround_{char2nr('Q')} = "``\r''"
endif
