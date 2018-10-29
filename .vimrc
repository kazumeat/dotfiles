syntax on
filetype on
filetype indent on

set number
" set relativenumber
set ruler
" backspaceの動作
set backspace=indent,eol,start
" カーソル移動の許可
set whichwrap=b,s,<,>,[,],,~
" 折り返さない
set nowrap
" 表示幅
set tabstop=4
" Tabキー押下時 カーソル移動幅
set softtabstop=4
" 自動インデント幅
set shiftwidth=4
" Tabキー押下 スペース
set expandtab
" ペースト時にずれないようにする
set paste
" Undo情報を保持
set undofile
" クリップボードに保持
set clipboard=unnamed,autoselect

"-------status line-----
"ステータスラインにコマンドを表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F
"変更のチェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ヘルプページなら[HELP]と表示
set statusline+=%h
"プレビューウインドウなら[Prevew]と表示
set statusline+=%w
"ファイルフォーマット表示
set statusline+=[%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y
"カレント行/全体行,カラム
set statusline+==%l/%L,%v
"undofile無効化
set noundofile
"全角対応
set ambiwidth=double

" 可視化
function! VimColors()
  highlight WhiteSpaceEOL ctermbg=red guibg=red
  highlight ZenkakuSpace ctermbg=green guibg=green
  highlight Tab ctermbg=blue guibg=blue
endfunction

if has('syntax')
  augroup VimColors
    autocmd!
    autocmd VimEnter,WinEnter * let w:m1 = matchadd('WhiteSpaceEOL', '\s\+$')
    autocmd VimEnter,WinEnter * let w:m2 = matchadd('ZenkakuSpace', '　')
    autocmd VimEnter,WinEnter * let w:m3 = matchadd('Tab', '\t')
  augroup END
  call VimColors()
endif

"dein Scripts-----------------------------
if &compatible
   set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim'))

call dein#add('Shougo/dein.vim')

" completion
    call dein#add('Shougo/neocomplete')
    call dein#add('Shougo/context_filetype.vim')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')

" interface
  " unite
    call dein#add('Shougo/unite.vim')

    call dein#add('Shougo/neomru.vim')
    call dein#add('Shougo/unite-outline')

  " filer
    call dein#add('Shougo/vimfiler.vim')

call dein#add('editorconfig/editorconfig-vim')

" color schema
"call dein#add('junegunn/seoul256.vim')

" Unified color scheme (default: dark)
"colo seoul256
"let g:seoul256_background = 256

colo desert

" file browse
call dein#add('scrooloose/nerdtree')
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

function! ToggleVExplorer()
    if !exists("t:netrw_bufnr")
        exec '1wincmd w'
        25Vexplore
        let t:netrw_bufnr = bufnr("%")
        return
    endif
    let win = bufwinnr(t:netrw_bufnr)
    if win != -1
        let cur = winnr()
        exe win . 'wincmd w'
        close
        exe cur . 'wincmd w'
    endif
    unlet t:netrw_bufnr
endfunction
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"  vim-quickhl
call dein#add('t9md/vim-quickhl')
"  high-light
" ハイライトする
map <Space>m <Plug>(quickhl-manual-this)
" ハイライトをすべて消す
map <Space>M <Plug>(quickhl-manual-reset)

"  commnet-out
call dein#add('tyru/caw.vim.git')
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

"  syntax
call dein#add('pangloss/vim-javascript')
call dein#add('hail2u/vim-css3-syntax')

"  extended % matching for HTML, LaTeX, and many other languages
call dein#add('vimtaku/hl_matchit.vim.git')

call dein#end()

filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" PHP syntax check.
" autocmd FileType php set makeprg=php\ -l\ %
" autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
"End dein Scripts-------------------------
