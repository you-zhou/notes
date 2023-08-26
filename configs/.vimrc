" ##############################
" # Location: ~/.vimrc
" # This file contains personal Vim settings.
" # Place this file in your home directory.
" ##############################

" Enable Line Numbers
set number

" Set Tab Width to 4 Spaces and Convert Tabs to Spaces
set tabstop=4
set expandtab
set shiftwidth=4

" Enable Auto-Indentation
set smartindent

" Enable Line Wrapping at 80 Characters
set wrap
set textwidth=80

" Enable Search Highlighting
set hlsearch

" Improve Searching by Making it Case-Insensitive Unless Capital Letters are Used
set ignorecase
set smartcase

" Note: For features like Syntax Highlighting, Mouse Support, Clipboard Support, and Themes,
" you may need to have a version of Vim compiled with the necessary support. Some of these
" features may be available depending on your specific Vim installation and version.

" Enable Syntax Highlighting (if supported)
syntax enable

" Enable Mouse Support in all Modes (if supported)
set mouse=a

" Enable Clipboard Support (if supported; may require Vim to be compiled with +clipboard)
set clipboard=unnamedplus

" Set a Theme (if supported; you may need to install a specific theme or use one available in your Vim installation)
" Example: color desert
