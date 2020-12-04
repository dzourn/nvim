call plug#begin('~/.config/nvim/bundle')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

"nvim-lspconfig
lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = false,
		signs = false,
		update_in_insert = false,
	} 
) 
--on_attach extended function
local on_attach = function(client)
require'completion'.on_attach(client)
end
--install pyls
require'lspconfig'.pyls.setup({on_attach=on_attach})
--install clang-tools, clangd and make it default
require'lspconfig'.clangd.setup({on_attach=on_attach})
--LspInstall bashls- needs npm
require'lspconfig'.bashls.setup{}
EOF


"completion-nvim
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_enable_auto_hover = 0
let g:completion_enable_auto_signature = 0
let g:completion_sorting = 'alphabet'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
set numberwidth=3
autocmd BufEnter * lua require'completion'.on_attach()

"vim-colorschemes
set background=dark
colorscheme molokai
"basic
syntax on
set number
set smarttab
set shiftwidth=4
set tabstop=4
set cursorline
set noswapfile
set mouse=a
set autoindent
set splitright
set signcolumn=no

"maps
"dd actually deletes
nnoremap d "_d
vnoremap d "_d
"<leader>dd cuts
nnoremap <leader>d ""d
vnoremap <leader>d ""d
nnoremap - $
vnoremap - $
inoremap <C-e> <C-o>$
inoremap <C-s> <C-o>0
inoremap jk <ESC>
noremap Y y$
inoremap (; ()<left>
inoremap (, (<CR>) <C-c>O
inoremap {, {<CR>} <C-c>O
inoremap {; {}<left>
inoremap [, [<CR>] <C-c>O
inoremap [; []<left>
inoremap "; ""<left>
inoremap '; ''<left>
nnoremap <C-j> :tabprevious<CR>                                             
nnoremap <C-k> :tabnext<CR>
nnoremap <Enter> o<ESC>

"status line
let s:hidden_all = 0
function! ToggleHidden()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
call ToggleHidden()

