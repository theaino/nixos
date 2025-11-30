{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules
  ];

	sops = {
		age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
	};

	wallpaper = {
		enable = true;
		path = ./res/wallpaper.png;
		theme = true;
	};

	mail = {
		enable = true;
		variant = "neomutt";
	};

	browser = {
		enable = true;
		variant = "qutebrowser";
	};

	editor = {
		enable = true;
		variant = "nvim";
	};

  home.username = "aino";
  home.homeDirectory = "/home/aino";

  home.stateVersion = "25.05";
}
