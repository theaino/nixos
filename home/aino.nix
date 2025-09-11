{ config, pkgs, ... }:

{
  home.username = "aino";
  home.homeDirectory = "/home/aino";

  home.packages = with pkgs; [
    st
    dmenu
    pavucontrol
    steam
    _1password-cli
    _1password-gui
  ];

  programs.git = {
    enable = true;
    userName = "Aino Spring";
    userEmail = "info@aino-spring.com";
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
      };
    };
    profiles = {
      "user" = {
        id = 0;
        isDefault = true;

        search.engines = {
	  "SearXNG" = {
	    urls = [{
	      template = "https://search.aino-spring.com/";
	      params = [
	        { name = "query"; value = "{searchTerms}"; }
	      ];
	    }];
	  };
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            definedAliases = [ "@no" ];
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
          };
        };
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  home.stateVersion = "25.05";
}
