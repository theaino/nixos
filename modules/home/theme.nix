{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  home.packages = with pkgs; [
    gnome-themes-extra
  ];
  
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        name = "Victor Mono Nerd Font";
        package = pkgs.nerd-fonts.victor-mono;
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity.terminal = 0.95;

    targets = {
      firefox = {
        firefoxGnomeTheme.enable = true;
        profileNames = [ "default" ];
      };
    };
  };
}
