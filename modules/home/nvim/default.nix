{ config, pkgs, ... }:

{
  programs.neovim = let
    lua = code: ''lua << END
${code}
END'';
  in {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number relativenumber

      set tabstop=2
	    set softtabstop=0
	    set shiftwidth=0
	    set shiftround
	    set expandtab

      filetype indent on

      set signcolumn=yes
      
      let mapleader = " "
      nnoremap <leader>d :lua vim.diagnostic.open_float()<cr>
      nnoremap <leader>y "+y
      nnoremap <leader>d "+d
      nnoremap <leader>p "+p
      vnoremap <leader>y "+y
      vnoremap <leader>d "+d
      vnoremap <leader>p "+p

    '' + lua ''
      vim.diagnostic.config({virtual_text = false, virtual_lines = {current_line = true, wrap = true}})
    '';
    plugins = [
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        config = lua ''
          vim.lsp.config("godot", {
            cmd = {"nc", "127.0.0.1", "6005"},
            filetypes = {"gdscript"},
            settings = {}
          })

          vim.lsp.enable("godot")
        '';
      }
      {
        plugin = pkgs.vimPlugins.mason-nvim;
        config = lua ''
          require("mason").setup()
        '';
      }
      {
        plugin = pkgs.vimPlugins.mason-lspconfig-nvim;
        config = lua ''
          require("mason-lspconfig").setup({
            ensure_installed = {}
          })
        '';
      }
      {
        plugin = pkgs.vimPlugins.coq_nvim;
        config = lua ''
          vim.g.coq_settings = { auto_start = "shut-up" }
          local coq = require("coq")
        '';
      }
      pkgs.vimPlugins.coq-artifacts
      pkgs.vimPlugins.coq-thirdparty

      {
        plugin = pkgs.vimPlugins.gbprod-nord;
        config = lua ''
          require("nord").setup({})
          vim.cmd.colorscheme("nord")
        '';
      }
    ];
  };
  home.sessionVariables.EDITOR = "nvim";
}
