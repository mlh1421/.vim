"if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

"setl foldmethod=marker
"vnoremap <buffer><silent> <space>x "ty:call execute(@t)<cr>
"nnoremap <buffer><silent> <space>x :call execute(getline(line('.')))<cr>
nnoremap <buffer><silent> <F5> :w<cr>:so %<cr>

nnoremap <buffer> <F6> :breakadd here<cr>