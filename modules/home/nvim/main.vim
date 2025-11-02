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
nnoremap <leader>a :lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>h :noh<cr>

" Buffers
nnoremap <leader>n :bn<cr>
nnoremap <leader>l :bl<cr>
nnoremap <leader>c :bd<cr>

" Copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>d "+d
vnoremap <leader>p "+p

" Telescope
nnoremap <leader>f :Telescope find_files<cr>
nnoremap <leader>/ :Telescope live_grep<cr>
nnoremap <leader>b :Telescope buffers<cr>
nnoremap <leader>r :lua require("telescope.builtin").lsp_references()<cr>
nnoremap <leader>o :lua require("telescope.builtin").lsp_definitions()<cr>

" Netrw config
let g:netrw_banner = 1
let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4

lua << END
vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true, wrap = true } })
END
