{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
		autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";

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
  };
}
