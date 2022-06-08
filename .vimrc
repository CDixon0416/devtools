"Casey's Original vimrc
"BakerB's super secret special vimrc
"Now with John Asper's secret sauce

"Adds line numbers
set number
"Adds relative numbers
set relativenumber
"Set maximum number of tab pages
set tabpagemax=100
"Show file title
set title
"Allow backspacing over indentation, line breaks, and insertion start
set backspace=indent,eol,start
"Disable swap files
set noswapfile
"Enable spellchecking
set spell

"Makes tab equal to 4 spaces
set tabstop=4
"Sets tabs and shift width to 4
set ts=4
set sw=4
"Sets tabs to spaces
set expandtab

"New lines inherit the indentation of previous lines
set autoindent
"Defaults to c style indentation whatever the fuck that means
set cindent

"Shows search highlighting
set hlsearch
"Makes searchs show partial matches
set incsearch
"Makes searchs ignore case
set ignorecase
"Disables ignorecase when an uppercase letter is used in the pattern
set smartcase
"Shows commands as they are typed
set showcmd
"Turn on autocomplete menu
set wildmenu

"Always highlight the cursor
set ruler
"Wrap lines
set wrap
"Syntax highlighting
syntax enable


"Set grep program to ripgrep, if it exists
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

"Cycle through tabs with just tab instead of ctrl + tab
nnoremap <Tab> :tabn<CR>
"Open NERDTree at git root
nnoremap <C-t> :NERDTreeVC<CR>

"Remove the need to type the g in front of common fugitive keys
:command Blame G blame
:command Log G log

"Set updatetime to 100ms so vim-gitgutter is faster
"set updatetime=100

"Commands to remember
"\hp preview
"\hs stage
"\hu undo

"Set NERDTree default enter to open in new tab
"Leave the dir argument blank to prevent enter
" on directories opening a blank tab
let NERDTreeCustomOpenArgs ={'file':{'where': 't'}, 'dir':{}}

"Auto run clang-format and make corrections on write
function ClangFormatBuffer()
    if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
        let cursor_pos = getpos('.')
        :%!clang-format
        call setpos('.', cursor_pos)
    endif
endfunction

"Run ClangFormatBuffer function over given file types
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call ClangFormatBuffer()

"Remove extra whitespace at the end of lines in all files
autocmd BufWritePre * :%s/\s\+$//e

"Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif

"Apply colorscheme found in ~/.vim/colors
colorscheme base16-tomorrow-night

"Make spellchecker use underlines instead
"Needs to be after any commands which change the colorscheme
hi clear SpellBad
hi SpellBad cterm=underline

"Install vim-plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    autocmd VimEnter * PlugClean --sync | source $MYVIMRC
endif

"Enable nerdtree
call plug#begin()
      Plug 'preservim/nerdtree'
      Plug 'tpope/vim-fugitive'
      Plug 'airblade/vim-gitgutter'
call plug#end()
