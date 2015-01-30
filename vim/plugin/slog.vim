" Clearable message log
" In part taken from this Stack Overflow answer
" <http://stackoverflow.com/a/8630598>

function! s:slog()
    for line in get(g:, 'messages', [])
        if line =~# '^echohl'
            exec line
        else
            echo line
        endif
    endfor
endfunction

function! s:echo(...)
    let g:messages = get(g:, 'messages', [])
    echom string(a:000)
    call add(g:messages, join(map(copy(a:000), 'eval(v:val)')))
endfunction

command! -bar Log call s:slog()
command! -bar Clear let g:messages = []
command! -nargs=+ -bar Echo call s:echo(<f-args>)
