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
    extraConfig = builtins.readFile ./main.vim;

    plugins = import ./plugins.nix { pkgs = pkgs; lua = lua; };
  };
  home.sessionVariables.EDITOR = "nvim";
}
