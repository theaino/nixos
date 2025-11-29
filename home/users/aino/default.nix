{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/dev.nix
    ./modules/util.nix
    ./modules/misc.nix
    ./modules/xdg.nix
    ./modules/nvim.nix
    ./modules/browser.nix
    ./modules/tex.nix
    ./modules/monitors.nix
    ./modules/theme.nix
    ./modules/msi.nix
    ./modules/cloud.nix
    ./modules/mail.nix
    ./modules/nixcord.nix
  ];

  home.username = "aino";
  home.homeDirectory = "/home/aino";

  home.stateVersion = "25.05";
}
