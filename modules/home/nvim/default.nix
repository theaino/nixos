{ config, pkgs, ... }:

{
  programs.neovim = {
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

      set autoindent
	  filetype plugin indent on
    '';
    plugins = let
      lua = code: ''lua << END
${code}
END'';
    in [
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
    ];
  };
  home.sessionVariables.EDITOR = "nvim";
}
