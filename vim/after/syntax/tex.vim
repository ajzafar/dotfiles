" Add aligned and gathered as valid TeX math environments
call TexNewMathZone('AA', 'aligned', 1)
call TexNewMathZone('AA', 'gathered', 1)

hi link texSuperscripts texSuperscript
hi link texSubscripts texSubscript
