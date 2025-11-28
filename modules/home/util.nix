{ config, pkgs, lib, inputs, scheme, ... }:

{
  home.packages = with pkgs; [
    dmenu
    j4-dmenu-desktop
    screen
    xclip
    zip
    unzip
    autorandr
    picocom
    bluetuith
    maim
    ripgrep
    xdg-utils
		pandoc
  ];

  programs.alacritty.enable = true;
  programs.zathura.enable = true;
  programs.feh.enable = true;
}
