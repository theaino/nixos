{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/home/dev.nix
    ../modules/home/util.nix
    ../modules/home/misc.nix
    ../modules/home/st
    ../modules/home/nvim
    ../modules/home/browser.nix
  ];

  home.username = "aino";
  home.homeDirectory = "/home/aino";

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

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
