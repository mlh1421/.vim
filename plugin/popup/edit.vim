call popup#add('edit-n', '编辑',
    \['i', '折叠    ' , "zc"],
    \['o', '展开折叠' , "zo"],
    \['p', '粘贴    ' , "\"+p"],
    \['a', '全选    ' , "ggVG"],
    \['n', '选择字体' , ":set gfn=*\<cr>"],
    \['/', '切换注释' , ":ToggleComment\<cr>"])

call popup#add('edit-v', '编辑',
    \['c', '复制    ' , "\"+y"],
    \['t', '剪切    ' , "\"+d"],
    \['p', '粘贴    ' , "\"+p"],
    \['/', '切换注释' , ":ToggleComment\<cr>"])

nmap <expr><m-e> Popup('edit-n')
vmap <expr><m-e> Popup('edit-v')
