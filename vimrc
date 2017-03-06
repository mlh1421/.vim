" =============================================================================
" Filename:     vimrc
" Author:       luzhlon
" Description:  vim startup script
" Last Change:  2017/2/20
" =============================================================================

so <sfile>:h/option.vim
so <sfile>:h/env.vim
"Load specifitic plugin
fun! s:LoadPlugin(p, ...)
    call plug#(a:p)
    if a:0|exe 'ru' 'config/'.a:1.'.vim'|endif
endf
fun! s:LocalPlugin(p, ...)
    exe 'set rtp+=' . a:p
    if a:0|exe 'ru' 'config/'.a:1.'.vim'|endif
endf
"load configuration file from current directory
fun! LoadCwd()
    let f = getcwd().'/.rc.vim'
    if filereadable(f)|exe 'so' f|endif
endf

call plug#begin('~/.vim/.plug')
com! -nargs=1 PlugLoad call <SID>LoadPlugin(<args>)
com! -nargs=1 LocaLoad call <SID>LocalPlugin(<args>)

    PlugLoad   'Lokaltog/vim-easymotion' , 'easymotion'
    PlugLoad   'Shougo/deoplete.nvim'    , 'deoplete'
    PlugLoad   'Tagbar'
    PlugLoad   'drmingdrmer/xptemplate'  , 'xptemplate'
    PlugLoad   'junegunn/vim-easy-align' , 'easyalign'
    PlugLoad   'scrooloose/nerdtree'     , 'nerdtree'
    PlugLoad   'tpope/vim-surround'      , 'surround'
    PlugLoad   'vim-airline/vim-airline' , 'airline'
    PlugLoad   'davidhalter/jedi-vim'    , 'jedi'
    PlugLoad   'luzhlon/popup.vim'
    PlugLoad   'luzhlon/util.vim'
    PlugLoad   'luzhlon/vim-markdown'    , 'markdown'
    PlugLoad   'chrisbra/csv.vim'
    PlugLoad   'Rip-Rip/clang_complete'  , 'clang'

    call LoadCwd()

delc PlugLoad
delc LocaLoad
call plug#end()

syntax on
filetype plugin indent on
