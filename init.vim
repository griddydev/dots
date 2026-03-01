lua << EOF
package.path = package.path .. ';/home/qwe/.local/share/nvim/site/pack/manual/start/nvim-treesitter/lua/?.lua'
EOF

" This is loaded if no vimrc file was found.
" Except when Vim is run with "-u NONE" or "-C".
" Individual settings can be reverted with ":set option&".
" Other commands can be reverted as mentioned below.

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Stop constant highlight spam on search
set nohlsearch

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" set ttymouse=sgr
set number
set tabstop=4
set shiftwidth=4

" title for dwl bar
set title
set titlestring=%F

" colorscheme
set background=light
set termguicolors
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox



" --- CursorLine Management ---

augroup ActiveCursorLine
  autocmd!

  " A. Split-Window Logic (setlocal)
  " Turn ON cursorline in the window you ENTER (only for that window)
  autocmd WinEnter * setlocal cursorline

  " Turn OFF cursorline in the window you LEAVE (only for that window)
  autocmd WinLeave * setlocal nocursorline

  " B. External Focus Logic (set)
  " When Neovim loses OS focus, turn OFF cursorline globally for this instance.
  " This is crucial for external terminal switching.
  autocmd FocusLost * set nocursorline

  " When Neovim gains OS focus, turn ON cursorline globally,
  " which immediately activates the cursorline in the *current* active split.
  autocmd FocusGained * set cursorline

  " C. Initial Setup
  " Ensure the first window starts correctly
  autocmd VimEnter * setlocal cursorline
augroup END

"set cursorline
set laststatus=0
set cmdheight=0
"set number relativenumber
set mouse=a
set nocompatible
set hidden
set ignorecase smartcase
"set incsearch hlsearch
set scrolloff=5

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" 1. Define a function to execute the chained commands
function! SplitTerm()
    split
    terminal
endfunction

" 2. Override the :terminal command to call the function
" (This should now work without the invalid -override flag)
command! Term call SplitTerm()

" 3. Map the lowercase command to your new capitalized command
" cnoreabbrev = Command-line Non-recursive Abbreviation
" This lets you type :term and Neovim executes :Term
cnoreabbrev term Term

" Set Neovim to start the terminal in Terminal mode (like Vim's default).
" The command will execute 'i' (insert) right after starting the terminal buffer.
"autocmd BufWinEnter,WinEnter term://* startinsert
autocmd TermOpen * startinsert

" This maps the split navigation keys to work inside the terminal.

" Switch to the split on the left (h)
tnoremap <C-h> <C-\><C-N><C-w>h

" Switch to the split below (j)
tnoremap <C-j> <C-\><C-N><C-w>j

" Switch to the split above (k)
tnoremap <C-k> <C-\><C-N><C-w>k

" Switch to the split on the right (l)
tnoremap <C-l> <C-\><C-N><C-w>l

" terminal enters on insert mode
autocmd BufEnter term://* startinsert

" yank from default clipboard
set clipboard=unnamedplus

" disable right clicl menu
set mousemodel=extend

" Poryscript syntax 
au BufRead,BufNewFile *.pory set filetype=pory
au FileType pory setlocal cindent

packloadall

lua << EOF
require'nvim-treesitter'.setup {
	ensure_installed = { },

	highlight = {
		enable = true,
	},

	indent = {
		enable = true
	}
}

-- Force Treesitter to start for C files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.treesitter.start()
  end,
})
EOF

