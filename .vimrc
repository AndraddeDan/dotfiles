set encoding=utf-8  " Codificação de caracteres UTF-8
set softtabstop=4   " Operações como o backspace também com 2 espaços
set ts=4            " tab vale 2 espaços
set sw=4            " tab com 2 espaços
set et              " Troca tabs por espaços
set ai              " Faz o auto tab/auto indent
set laststatus=2    " Mostra os status junto com o Plugin Lightline
set relativenumber  " Mostra o número de linhas em relação ao cursor e não do arquivo inteiro
set wildmenu                                   " Menu com as opções do vim usando tab

set dir=~/.vim_temp/swap//,/var/tmp//,/tmp//,. " Guarda os arquivos em uma pasta fixa, e não na pasta corrente
set backup
set backupdir=~/.vim_temp/backup " Guarda os arquivos de backup em uma pasta fixa, e não na pasta corrente
set undodir=~/.vim_temp/undo "Persistir os arquivos refazer
set undofile
set undolevels=1000 "maximum number of changes that can be undone

set backspace=indent,eol,start " Corrige problemas com o backspace

set cursorline      "linha atual com destaque

set ignorecase
set foldmethod=indent
set foldlevel=20

" Mudando o leader
let mapleader="\<Space>"
let maplocalleader="\<Space>"

" AutoCompletes e configurações por linguagem
set complete=".,w,b,u,t,i,U"
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

nnoremap ; :
inoremap jj <esc>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

call plug#begin('~/.vim/plugged')

" Lightline: statusline/tabline
Plug 'itchyny/lightline.vim'

" ==== lightline settings ====
let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'active': {
    \   'left': [['mode'], ['readonly', 'modified'], ['relativepath']],
    \   'right': [['lineinfo'], ['filetype'], ['fileencoding', 'fileformat']]
    \ },
    \ 'inactive': {
    \   'left': [['absolutepath']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'tabline': {
    \   'right': [['fugitive']]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'relativepath': 'Relative'
    \ },
    \ 'component': {
    \   'lineinfo': '%l\%L [%p%%], %c, %n',
    \ }
    \ }

set noshowmode
" ==== Functions lightline    ====
function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0 "._ : ''
  endif
  return ''
endfunction

function! Relative()
    return expand("%:f")
endfunction

" ==== End lightline settings ====

" UltiSnips: Snippets Track the engine.
Plug 'SirVer/ultisnips'
"
" " Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
"
" " Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-y>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-w>"
let g:UltiSnipsJumpBackwardTrigger="<c-q>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

Plug 'plasticboy/vim-markdown'
Plug 'jacoborus/tender'
Plug 'sjl/badwolf'
Plug 'nightsense/seabird'
Plug 'w0ng/vim-hybrid'


Plug 'scrooloose/nerdtree'
let g:nerdtree_tabs_smart_startup_focus = 0
let g:nerdtree_tabs_open_on_gui_startup = 0 " Impede do nerdtree abrir junto com o GVim
map <leader>t :NERDTreeToggle<CR>

Plug 'Townk/vim-autoclose'

Plug 'ap/vim-css-color'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
map <leader>m :FZF <CR>

Plug 'scrooloose/syntastic', {'do': 'composer global require squizlabs/php_codesniffer' }
nnoremap <Leader>s :SyntasticCheck<CR>
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_php_phpcs_args='--standard=PSR2'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-J>'

call plug#end()


" Habilita Configuração de cores


set t_Co=256
set background=dark
colorscheme badwolf " Esquema de cores do vim koehler 

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"                                                                                            
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
syntax enable       " Habilita a sintaxe
