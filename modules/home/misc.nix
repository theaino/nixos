{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    steam
    _1password-cli
    _1password-gui
    orca-slicer
    thunderbird
    libreoffice-still
    godot-mono
    gimp3-with-plugins
  ];
}
