{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    dmenu
    screen
    xclip
    zip
    unzip
    autorandr
    picocom
  ];
}
