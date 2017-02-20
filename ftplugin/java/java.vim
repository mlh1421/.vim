"if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

inoremap <buffer> <m-s><m-n> ==<space>null

com! -buffer Assign exe 'Tabularize /\w\+\s\+=' \| exe 'Tabularize /='

nmap <F5> :!javac % && java %<<cr>
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F5> <Plug>(JavaComplete-Imports-Add)
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <F8> <Plug>(JavaComplete-Imports-SortImports)