set number relativenumber
set scrolloff=8

set tabstop=2
set softtabstop=0
set shiftwidth=0
set shiftround
set expandtab

filetype indent on

set signcolumn=yes

let mapleader = " "
nnoremap <leader>d :lua vim.diagnostic.open_float()<cr>
nnoremap <leader>h :noh<cr>

" Copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>d "+d
vnoremap <leader>p "+p


lua << END
vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true, wrap = true } })
END
