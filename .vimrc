""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"CONFIGURAÇÕES PESSOAIS DO VIM :

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"INÍCIO DA SEÇÃO DE MAPEAMENTO DE TECLAS

"REDIRECIONAMENTO DE jj PARA O ESC
nnoremap ; :

"REDIRECIONAMENTO DE ; PARA :
inoremap jj <esc>

"MUDANDO A TECLA LEADER
let mapleader="\<Space>"
let maplocalleader="\<Space>"

" `gf` abre o arquivo sobre o cursor em um split vertical
nnoremap gf :vertical wincmd f<CR>


"FIM DA SEÇÃO DE MAPEAMENTO DE TECLA!
"ESTAS SÃO DE EXTREMA IMPORTANCIA PARA O FUNCIONAMENTO DOS DEMAIS ATALHOS POR ISSO FICAM ACIMA DE TUDO!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"INÍCIO DAS CONFIGURAÇÕES DE PLUGIN

"EXECUTA O GERENCIADOR DE PLUGIN 'PATHOGEN'
execute pathogen#infect()

"******************* NERDTREE *****************************

"CONFIGURANDO O PLUGIN NERDTREE :

"iniciando automaticamente com o vim idependentemente se foi especificado um arquivo :
"autocmd vimenter * NERDTree

"iniciando automaticamente com o vim se um arquivo não for especificado
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif 

"iniciando automaticamente com o vim ao abrir um diretorio
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"Impede do nerdtree abrir junto com o GVim
let g:nerdtree_tabs_smart_startup_focus = 0
let g:nerdtree_tabs_open_on_gui_startup = 0 

"inicando o nerdtree ao teclar o atalho <space>+t :
map <leader>t :NERDTreeToggle<CR>

"fechando o vim se a unica janela for a do nerdtree :
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" configurando a exibição das setinhas de pastas abertas ou fechadas no nerdtree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

"******************* LIGHTLINE ****************************

"CONFIGURANDO O PLUGIN LIGHTLINE :

let g:lightline = {
			\ 'colorscheme': 'powerline',
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '<', 'right': '>' },
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

function! LightlineReadonly()
	return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! LightlineFilename()
	let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? ' +' : ''
	return filename . modified
endfunction

function! LightlineMode()
	return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
				\ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
				\ &filetype ==# 'unite' ? 'Unite' :
				\ &filetype ==# 'vimfiler' ? 'VimFiler' :
				\ &filetype ==# 'vimshell' ? 'VimShell' :
				\ lightline#mode()
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! Relative()
	return expand("%:f")
endfunction

function! LightlineFilename()
	return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
				\ &filetype ==# 'unite' ? unite#get_status_string() :
				\ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
				\ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

"******************* VIM ARLINE ***************************

"ATIVA O VIM ARLINE NA BARRA DE STATUS (ELE DEIXA TUDO IDENTADO COM <> #BELEZA)

"barra de abas
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"barra inferior
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

"******************* FZF **********************************

"ATIVANDO O FUZZY FINDER
set rtp+=~/.fzf
map <leader>m :FZF <CR>


"******************* EMMET ********************************

"MAPEANDO O LEADER DO EMMET P/ Ctrl+J
let g:user_emmet_leader_key='<C-J>'

"******************* YouCompletMe *************************

"https://github.com/Valloric/YouCompleteMe
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

"impedir que a janela de preview abra
set completeopt-=preview

"******************* Syntastic ****************************

"Recomended Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Checando sintaxe com  <space>+s
nnoremap <Leader>c :SyntasticCheck<CR>

"linguagens adicionadas para checagem
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_php_phpcs_args='--standard=PSR2'

"******************* Prettier *****************************

map <leader>s :Prettier<CR>

"******************* TSUQUYOMI ****************************

let g:tsuquyomi_completion_detail = 1

"Integração com o syntastic
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

"*************** VIM ARLINE THEMES ************************

"******************* AUTOCLOSE ****************************

"******************* TYPESCRIPT ***************************

"******************* CSS COLOR ****************************

"********************* VIMPROC ****************************


"FIM DAS CONFIGURAÇÕES DE PLUGIN!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"CONFIGURAÇÕES GERAIS	:

"USAR CARACTERES UTF-8
set enc=utf-8

"MOSTRA O NÚMERO DA LINHA ATUAL
set number

"MOSTRA O NÚMERO DE LINHAS  DO LADO ESQUERDO EM RELAÇÃO AO CURSOR E NÃO AO ARQUIVO INTEIRO
set relativenumber

"IGNORA A BUSCA/USO ENTRE MAIÚSCULAS E MINÚSCULAS
set ignorecase

"VALOR SETADO PARA UM TAB
set tabstop=4

"TROCAR TAB POR ESPAÇOS
set et

"LARGURA DA TABULAÇÃO/IDENTAÇÃO DE UM ARQUIVO
set shiftwidth=2

"LINHA ATUAL COM DESTAQUE
set cursorline

"BARRA DE STATUS  NO FIM DA JANELA
set laststatus=2

"OCULTA A EXIBIÇÃO DE STATUS/MODO DE EDIÇÃO
set noshowmode

"IDENTA CONFORME TIPO DE ARQUIVO
filetype plugin indent on

"HABILITA O BACKSPACE
set backspace=2

"FAZ O AUTO TAB/AUTO INDENT
set ai

"MENU COM AS OPÇÕES DO VIM USANDO TAB
set wildmenu

"Ignora certos tipos de arquivos com o tab :
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
"set wildignore+=node_modules/*,bower_components/*

"Melhores explicações em : http://vim.wikia.com/wiki/Folding
set foldmethod=indent
set foldlevel=20

"FIM DAS CONFIGURAÇÕES GERAIS!

"******************* PASTA DE BACKUP/TMP *******************

"GUARDA OS ARQUIVOS DE EDIÇÃO EM UMA PASTA FIXA, E NÃO NA PASTA CORRENTE/ATUAL
set dir=~/.vim/swap/tmp/

"SETA A POSSIBILIDADE DE BACKUP DOS ARQUIVOS EM EDIÇÃO
set backup

"GUARDA OS ARQUIVOS DE BACKUP EM UMA PASTA FIXA, E NÃO NA PASTA CORRENTE/ATUAL
set backupdir=~/.vim/swap/backup/

"PERSISTIR OS ARQUIVOS REFAZER
set undofile
set undodir=~/.vim/undo/

"NÚMERO MÁXIMO DE MUDANÇAS QUE PODEM SER DESFEITAS
"set undolevels=1000

"******************* BUSCA DE PALAVRAS **********************

"BUSCA INCREMENTAL -> FAZ A BUSCA EM TEMPO REAL DESTACANDO-A
set incsearch

"DESTACA OS RESULTADOS DE UMA BUSCA
set hlsearch

"LIMPAR O DESTAQUE DA BUSCA AO DAR O COMANDO <space>+l
nnoremap <silent> <Space>l :nohlsearch<Bar>:echo<CR>

"******************* COPY/PASTE *****************************

"COPIAR E COLAR DO BUFFER DO WINDOWS/SISTEMA :

"<space>+y -> copia no modo visual com y minúsculo
vmap <Leader>y "+y
"<space>+Y -> copia no modo visual com Y maiúsculo
vmap <Leader>Y "+Y 

"<space>+p -> cola no modo normal com p minúsculo
nmap <Leader>p "+p
"<space>+P -> cola no modo normal com P maiúsculo
nmap <Leader>P "+P

"<space>+p -> cola no modo visual com p minúsculo
vmap <Leader>p "+p
"<space>+P -> cola no modo visual com P maiúsculo
vmap <Leader>P "+P

"******************* COLORS SETTINGS ************************

"HABILITA A SINTAXE DE CORES
syntax on

"SETA O ESQUEMA DE CORES DE FORMA MAIS OPACA E COM MENOS OPÇÕES
set termguicolors "Se as cores estiverem dando erro provavel que o emulador de terminal usado não suporte 256 cores

"AJUSTA E CORRIGE AS CORES CONFORME O SUPORTE DO TERMINAL
"set t_8f=[38;2;%lu;%lu;%lum
"set t_8b=[38;2;%lu;%lu;%lum
"syntax enable

"DECLARA UM BACKGROUND COLOR DARK
set background=dark

"ESQUEMA DE CORES
colorscheme gruvbox

"colorscheme badwolf
"colorscheme Tomorrow-Night-Eighties
"colorscheme gruvbox

"******************* GRUVBOX SETTINGS *********************

"CONFIGURANDO O GRUVBOX
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

"OPÇÕES DE TEXTO
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
