{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  #dconf.settings."org/gnome/desktop/interface" = {
  #  gtk-theme = lib.mkForce "Nordic";
  #  color-scheme = "prefer-dark";
  #};

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
