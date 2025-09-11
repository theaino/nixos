{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.override {
        conf = ./config.def.h;
	patches = [
	  (pkgs.fetchpatch {
	    url = "https://dwm.suckless.org/patches/noborder/dwm-noborderfloatingfix-6.2.diff";
	    hash = "sha256-osxrOsizPhOpQ1a+tDPMbmKsjvA+FMC8ZwbfiINnnYQ=";
	  })
	  (pkgs.fetchpatch {
	    url = "https://dwm.suckless.org/patches/combo/dwm-combo-6.1.diff";
	    hash = "sha256-0q2IlbdDy17n6Ji2gBKxBxtkMd8rE8EY+ANMweqcHa0=";
	  })
	];
      };
    };
  };
}
