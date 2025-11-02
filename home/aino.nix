{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/home/dev.nix
    ../modules/home/util.nix
    ../modules/home/misc.nix
    ../modules/home/xdg.nix
    ../modules/home/st
    ../modules/home/nvim
    ../modules/home/browser.nix
    ../modules/home/tex.nix
    ../modules/home/wallpaper
    ../modules/home/monitors.nix
    ../modules/home/theme.nix
    ../modules/home/msi.nix
  ];

  home.username = "aino";
  home.homeDirectory = "/home/aino";

  home.stateVersion = "25.05";
}
