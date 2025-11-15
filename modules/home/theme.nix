{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnome-themes-extra
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Arc-Dark";
  };

  #dconf.settings."org/gnome/desktop/interface" = {
    #gtk-theme = lib.mkForce "Nordic";
    #color-scheme = "prefer-dark";
  #};

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
