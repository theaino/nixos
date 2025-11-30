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
		libsixel

		sops
		age
  ];

  programs.alacritty = {
		enable = true;
		package = pkgs.alacritty-graphics;
	};
  programs.zathura.enable = true;
  programs.feh.enable = true;

	home.sessionVariables = {
		TERMINAL = "alacritty";
	};
}
