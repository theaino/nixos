{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/home/dev.nix
    ../modules/home/util.nix
    ../modules/home/misc.nix
    ../modules/home/st
    ../modules/home/nvim
    ../modules/home/browser.nix
    ../modules/home/tex.nix
    ../modules/home/wallpaper
    ../modules/home/monitors.nix
    ../modules/home/theme.nix
  ];

  home.username = "aino";
  home.homeDirectory = "/home/aino";

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  home.stateVersion = "25.05";
}
