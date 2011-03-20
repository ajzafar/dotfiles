" A few functions that toggle between two option states

""" FormatToggle()
" For use in a mapping. Toggles automatic formatting of text.
function! toggle#FormatToggle()
    if &fo =~ '[at]'
        setl fo-=a fo-=t
    else
        setl fo+=a fo+=t
    endif
    setl fo?
endfunction

""" CCToggle()
if exists('+cc')
    " For use in a map. Toggles highlighting of 'tw'+1.
    function! toggle#CCToggle()
        if empty(&cc)
            setl cc=+1
        else
            setl cc&
        endif
        setl cc?
    endfunction
endif

""" MouseToggle()
if exists('+mouse')
    " For use in a map. Toggles mouse usage in normal mode.
    function! toggle#MouseToggle()
        if &mouse =~ 'n'
            setl mouse-=n
        else
            setl mouse+=n
        endif
        setl mouse?
    endfunction
endif

"" Taken from godlygeek's vimrc. Pretty nice way to handle folding.
"" vim:fdm=expr
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
