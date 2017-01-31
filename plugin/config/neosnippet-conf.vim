" Plugin key-mappings.
imap <m-u>  <Plug>(neosnippet_expand_or_jump)
smap <m-u>  <Plug>(neosnippet_expand_or_jump)
xmap <m-u>  <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
"\ pumvisible() ? "\<C-n>" :
"\ neosnippet#expandable_or_jumpable() ?
"\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'