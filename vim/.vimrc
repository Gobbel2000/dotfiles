source $VIMRUNTIME/defaults.vim

" To make resizing work
set term=xterm-color

" From Kitty FAQ:
" https://github.com/kovidgoyal/kitty/blob/master/docs/faq.rst#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
"
" Mouse support
set balloonevalterm
" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
"" 2 for (nonblinking) block, 5 for bar, 4, for (nonblinking) underline
let &t_SI = "\e[2 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"

" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''


" From Kitty discussion:
" https://github.com/kovidgoyal/kitty/issues/108#issuecomment-320492772
"
" General colors
if has('gui_running') || has('nvim') 
    hi Normal         guifg=#f6f3e8 guibg=#000000 
else
    " Set the terminal default background and foreground colors, thereby
    " improving performance by not needing to set these colors on empty cells.
    hi Normal guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
    let &t_ti = &t_ti . "\033]10;#f6f3e8\007\033]11;#000000\007"
    let &t_te = &t_te . "\033]110\007\033]111\007"
endif


" From /usr/share/vim/vim82/vimrc_example.vim
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

"if &diff
"    colorscheme pablo
"endif

set background=dark

set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab
set clipboard=unnamedplus
set langmap=hk,jh,kj
set listchars=tab:>-,trail:-
set autoindent
set autowriteall
set textwidth=79

" Shortcuts
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <silent> <C-p> <Plug>(ale_go_to_definition)

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0

let g:ale_linters = {
            \'python': ['ruff', 'mypy', 'pylsp'],
            \'rust': ['analyzer'],
            \'bash': ['shellcheck'],
            \'sh': ['shellcheck']
            \}
let g:ale_linters_explicit = 1
let g:ale_python_pylsp_config = {
            \    'pylsp': {
            \        'plugins': {
            \            'mccabe': {
            \                'enabled': v:false
            \            },
            \            'pyflakes': {
            \                'enabled': v:false
            \            },
            \            'pycodestyle': {
            \                'enabled': v:false
            \            },
            \            'autopep8': {
            \                'enabled': v:false
            \            },
            \            'yapf': {
            \                'enabled': v:false
            \            },
            \        }
            \    }
            \}
let g:ale_python_mypy_options = "--ignore-missing-imports"
let g:ale_python_mypy_ignore_invalid_syntax = 1

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
" This setting might disabe third-party snippets
"let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
Plug 'SirVer/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'

call plug#end()
