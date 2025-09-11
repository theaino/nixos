{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.override {
        conf = ./config.def.h;
      };
    };
  };
}
