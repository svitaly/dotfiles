" === === === === === === ===
" ===   GENERAL SETTINGS  ===
" === === === === === === ===

" Added 'export LC_ALL=en_US.UTF-8' to .zshrc to start vim without locale Warnings!

set nocompatible                          "Some unknown shit
set encoding=utf-8                        "Set encoding to UTF-8"
set backspace=indent,eol,start            "Making sure backspace works
set number relativenumber                 "Set line numbers and relative number, also can be written as 'set nu rnu'
set nocursorline                          "Turn of active line highlight, potentially boosts VIM performance
set lazyredraw                            "Do not redraw screen when playing macros
set smartindent                           "Smart indentation
"set timeoutlen=1000 ttimeoutlen=0
set wrap linebreak                        "Word wrapping without breaking the words
set showcmd                               "Show command line at the bottom of the screen"
"set clipboard+=unnamed
set incsearch                             "Searches as you type (Incremental search)
filetype off                              "Filetype detection
set nobackup                              "Turn off backup writing before saving file
set nowritebackup                         "Turn off backup file writing before saving file
set noswapfile                            "Turn off swap file"
set list                                  "Show all unprinted chars:
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:» "How to show unprinted chars
set formatoptions-=tc                     "Turn off auto wordwrap
"set spell                                 "Enable spellcheck globally on all filetypes
autocmd FileType markdown setlocal spell  "Enable spellcheck only for MarkDown files
set spelllang=en_us,ru_Ru                 "Add spellcheck for English and Russian languages

" === Setting indentation / tabs ===
set tabstop=2                             "Spaces in one tab char
set shiftwidth=2                          "Indentation by # of spaces
" set cursorcolumn                        "Crosshair cursor vertical axis
" set cursorline                          "Crosshair cursor horizontal axis
set expandtab                             "Changes tabs to spaces

" === Foldind settings ===
" set foldmethod=syntax                   "Set folding rules - fold by syntax
" set foldnestmax=10                      "How many folds can be inside each other
" set nofoldenable                        "Open file with all lines UNfolded
" set foldlevel=2                         "Level of folding


" === === === === === === ===
" ===   PLUGIN SECTION    ===
" === === === === === === ===
"
call plug#begin('~/.vim/plugged')
  Plug 'mhartington/oceanic-next'         "Colorscheme OceanicNext
  "Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete plugin based  on TLS
  "Plug 'tpope/vim-surround'              "Surround plugin
  Plug 'itchyny/lightline.vim'            "Light status line 
  Plug 'sheerun/vim-polyglot'             "Syntax highlighting
  Plug 'jiangmiao/auto-pairs'             "Auto pair all the brackets
  Plug 'Yggdroot/indentLine'              "Indentation line
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


" === === === === === === ===
" ===   KEY MAPPINGS      ===
" === === === === === === ===

" Start Node js script after pressing ,l :
map ,l :!clear<cr> :!node %<cr>
