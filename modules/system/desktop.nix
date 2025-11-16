{ config, pkgs, ... }:

{
  programs.dconf.enable = true;
  services.dbus.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.wallpaper.mode = "fill";
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
      };
    };
  };

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "aino";
  };

  services.picom.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "escape";
  	        escape = "capslock";
          };
          otherlayer = {};
        };
      };
    };
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
