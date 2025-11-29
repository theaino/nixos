{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules
  ];

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
