" ===   GENERAL SETTINGS  ===

" Added 'export LC_ALL=en_US.UTF-8' to .zshrc to start vim without locale Warnings!

set encoding=utf-8                        "Set encoding to UTF-8"
set backspace=indent,eol,start            "Making sure backspace works
set number relativenumber                 "Set line numbers and relative number, also can be written as 'set nu rnu'
set wildmenu                              "Turn on wildmenu suggestions
"set nocursorline                          "Turn of active line highlight, potentially boosts VIM performance
"set timeoutlen=1000 ttimeoutlen=0
set wrap linebreak                        "Word wrapping without breaking the words
set showcmd                               "Show commands entered from keyboard
"set clipboard+=unnamed
set incsearch                             "Searches as you type (Incremental search)
set list                                  "Show all unprinted chars:
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:» "How to show unprinted chars
"set formatoptions-=tc                     "Turn off auto wordwrap
set tabstop=4                             "Spaces in one tab char
set shiftwidth=4                          "Indentation by # of spaces
" set cursorcolumn                        "Crosshair cursor vertical axis
" set cursorline                          "Crosshair cursor horizontal axis
set expandtab                             "Changes tabs to spaces
" set foldmethod=syntax                   "Set folding rules - fold by syntax
" set foldnestmax=10                      "How many folds can be inside each other
" set nofoldenable                        "Open file with all lines UNfolded
" set foldlevel=2                         "Level of folding


" ===   PLUGIN SECTION    ===

call plug#begin('~/.vim/plugged')
  Plug 'mhartington/oceanic-next'         "Colorscheme OceanicNext
  "Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete plugin based  on TLS
  "Plug 'tpope/vim-surround'              "Surround plugin
  Plug 'pangloss/vim-javascript'          "JS syntax highlight and indentation
  Plug 'itchyny/lightline.vim'            "Light status line 
  Plug 'jiangmiao/auto-pairs'             "Auto pair all the brackets
call plug#end()

" === Colorscheme Configuration ===
syntax on                                 "Turn on syntax highlight
colorscheme OceanicNext                   "Turn on OceanicNext theme installed by plugin

" === LightLine configuration  ===
set laststatus=2                          "Always show status line - Lightline"
"Setting colorscheme for Lightline:
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


" ===   KEY MAPPINGS      ===

" Start Node js script after pressing ,l :
map ,l :!clear<CR> :!node %<CR>
" Toggle list option CTRL + M:
noremap <C-M> :set invlist<CR>
