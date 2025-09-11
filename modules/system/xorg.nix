{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    /*displayManager.startx.enable = false;*/
  };

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "aino";
  };
}
