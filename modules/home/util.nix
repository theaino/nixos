{ config, pkgs, lib, ... }:

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
    feh
    zathura
    maim
    ripgrep
    xdg-utils
  ];
}
