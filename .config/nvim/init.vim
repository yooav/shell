"General Settings
"----------------

"syntax highlighting
syntax on

"filetype specific syntax highlighting
"USAGE NOTES:
"Create a directory named ~/.config/nvim/ftplugin  to manage your filetype
"specific behavior e.g. tabbing behavior, custom highlighting, etc.
"Each filetype will have its own file to manage its custom behavior
"Ex: ~/.config/nvim/ftplugin/go.vim handles specific configs for go files
filetype plugin indent on

"Speed up syntax handling for javascript and typescript
"https://stackoverflow.com/questions/19030290/syntax-highlighting-causes-terrible-lag-in-vim
set re=0

"Show line numbers
set number

"Tab button set to 4 spaces
set shiftwidth=4

"VimPlug plugins
"https://github.com/junegunn/vim-plug for info and installation
"---------------
call plug#begin()
"You may need to create directory for plugs at ~/.local/share/nvim/plugged
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'jacoborus/tender.vim'

"Git Plugins
Plug 'ruifm/gitlinker.nvim'
Plug 'f-person/git-blame.nvim'

"For-Fun Plugins
Plug 'gaborvecsei/cryptoprice.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'goolord/alpha-nvim'
call plug#end()

"Settings for Telescope & Plenary
"--------------------------------
" Find files using Telescope command-line sugar.
" create ~/.config/nvim/lua/modules directory
" initialize telescope in ~/.config/nvim/modules/telescope.lua with require
" and setup
lua require('modules/telescope')
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep_args<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Fzf shortcuts
nnoremap <leader>h <cmd>History<cr>

lua require('gitlinker').setup()
" <leader>gy to get link of current file

lua require('gitblame').setup({enabled=false})
nnoremap <leader>gb <cmd>GitBlameToggle<cr>

lua require('modules/indent')

nnoremap <leader>cy <cmd>lua require('cryptoprice').toggle()<cr>

lua require('alpha').setup(require('alpha.themes.startify').config)

nnoremap <leader>e <cmd>Explore<cr>

"Settings for Gruvbox Colorscheme (specific to Iterm2)
"-----------------------------------------------------
"colorscheme gruvbox
"colorscheme desert
set background=dark
let g:gruvbox_italic=1
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" Settings for Tender Colorscheme
" -------------------------------
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Theme
syntax enable
colorscheme tender
