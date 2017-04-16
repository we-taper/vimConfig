" ============================================================
" Vimrc. Author: WE.TapEr Version: 1.2
"
" ============================================================
"                   An Outline for this Vimrc
" ============================================================
" @1 The Default Settings (The default set by then Vim installer)
" @2 Plugins (For various plugins)
"   @2.1 For Vundle
"   @2.2 For vimtex
"   @2.3 For UltiSnips
"   @2.4 For Neocomplete
"   @
" @3 Vim UI Configuration (Adjusting the appearance of Vim, 
"                           specifically, the gVim)
" @4 Miscellaneous Settings 
" ================================================================
" @1 The Default Settings
set nocompatible

" Change the Display language into English. It is advisable to
" set language before other configurations.
language English

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"
" ================================================================
"  @2  Plugins 
" ================================================================

" ================================================================
" @2.1 Below is for Vundle -- The Vim plugin manager
"
filetype off                  " required

" set the runtime path to include Vundle and initialize
" with modification shown in: https://github.com/VundleVim/Vundle.vim/wiki/Vundle-for-Windows
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin('$VIM/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'lervag/vimtex'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Konfekt/FastFold'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'godlygeek/tabular'
Plugin 'morhetz/gruvbox'
Plugin 'atelierbram/vim-colors_atelier-schemes'
" =====================================================================
" Below is for Ultisnips only
"
    " Track the engine.
    Plugin 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plugin 'honza/vim-snippets'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :help vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" 
" ======================================================================


" =============================================================
" @2.2 For vimtex
" 1. Enable SumatrPDF reader to view the output pdf
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
" 2. Enable the keyboard shortcuts.
let maplocalleader = ","
" 3. Enable TeX-specific code folding.
let g:vimtex_fold_enabled=1
" let g:vimtex_fold_manual=0
" 4. Ignore certain Latex warnings
let g:vimtex_quickfix_ignored_warnings = [
    \ 'Overfull',
    \ 'Underfull',
	\ 'PDF inclusion',
  \ ]


" =====================================================================
" @2.3 Below is also for UltiSnips
" 
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<A-8>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " Add an self defined folder for own Snippets. [optional]
" let g:UltiSnipsSnippetDirectories=['UltiSnips','C:\Users\we.taper\Desktop\Draft\UltiSnips']
" If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

" =====================================================================
" @2.4 Below is also for Neocomplete
" 
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Below is for neocomplete for cooperate with vimtex plugin
if !exists('g:neocomplete#sources#omni#input_patterns')
let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
    \ '\v\\%('
    \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
    \ . '|hyperref\s*\[[^]]*'
    \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|%(include%(only)?|input)\s*\{[^}]*'
    \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . ')'

" =====================================================================
" @3 Vim UI Configuration
" 
" Replace <tab> with 2 spaces
set expandtab
set tabstop=4
set shiftwidth=4
" Change color [recommanded]
" set background=light
" colorscheme Atelier_SulphurpoolDark
" Displaying line numbers.
set number
" ... and display them relative to the current position of cursor
set relativenumber
" Always show one more line on top or bottum, so that the editing
" experience is more continuous.
set scrolloff=1
" Change the font to a more favorable one:Anonymous_Pro  [optional]
" (from: http://www.marksimonson.com/fonts/view/anonymous-pro)
" if has('gui_running')
"     set guifont=Anonymous_Pro:h11:cANSI:qDRAFT
" endif

" ================================================================
" @4 Miscellaneous Settings
"
" Change default encoding to utf-8
set encoding=utf-8
" Making 'j' and 'k' work on visual line
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j
" Making 'Shift-tab' to back-indentation
inoremap <S-tab> <C-d>
" Since '^' is more convenient than '0', exchange their roles
nnoremap ^ 0
nnoremap 0 ^
" Enable Python interaction, note that normally `py` command does not
" work properly.
let $PYTHONPATH = "D:\\App\\Python\\Python 2.7\\Lib;D:\\App\\Python\\Python 2.7\\DLLs;D:\\App\\Python\\Python 2.7\\Lib\\lib-tk"
" For convenient Case search
set ignorecase
set smartcase
" For avoiding the \"~\" file clustering on my system
set backupdir-=.
set backupdir^=~\vim-backup-file
" For avoiding the \"un~\" file clustering on my system
set noundofile
" When Vim is split in my screen, the best textwidth is
set textwidth=70
" Search for visually selected text using key combination '//' 
vnoremap // y/<C-R>"<CR>
