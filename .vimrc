
set nu
set ts=4
set sw=4
set wildcharm=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
set completeopt=longest,menuone
set clipboard=unnamed
set autoindent
 
set guioptions-=a "MS copy&paste disable"
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set completeopt+=longest

set noswapfile
 
set smartcase

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'escher9/throughpairs'
Plugin 'ctrlp.vim'
Plugin 'Tagbar'
Plugin 'multiselect'
Plugin 'align'
Plugin 'genutils'
Plugin 'calendar.vim'
Plugin 'surround.vim'
Plugin 'repeat.vim'

Plugin 'vim-ruby/vim-ruby'
Plugin 'Valloric/YouCompleteMe'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Conque-Shell'
" Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on
let g:mwDefaultHighlightingPalette = 'extended'

" let g:airline#extensions#tabline#enabled = 1



" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" always show statusline
set laststatus=2
" use 256 colors
" set t_Co=256

" let g:airline_powerline_fonts = 1


autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete

set autochdir

au FileType * lcd %:p:h
