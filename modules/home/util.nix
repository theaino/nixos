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
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = lib.mkForce 10;
    };
  };
  programs.zathura.enable = true;
  programs.feh.enable = true;
}
