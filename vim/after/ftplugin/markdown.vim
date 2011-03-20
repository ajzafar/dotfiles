" Add vim-surround shortcut for headers
let b:header_re = "\r".'^\(\d\).*'."\r".'\=repeat("#",submatch(1))'
let b:surround_{char2nr('#')} = "\1level: " . b:header_re . "\1 \r \1"
            \                               . b:header_re . "\1"
