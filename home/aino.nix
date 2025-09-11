{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/home/st
    ../modules/home/nvim
  ];

  home.username = "aino";
  home.homeDirectory = "/home/aino";

  home.packages = with pkgs; [
    dmenu
    pavucontrol
    steam
    _1password-cli
    _1password-gui
    git
    gh
  ];

  programs.git = {
    enable = true;
    userName = "Aino Spring";
    userEmail = "info@aino-spring.com";
    extraConfig = {
      "credential \"https://github.com\"" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
      "credential \"https://gist.github.com\"" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };
  };

  programs.firefox = {
    enable = true;

    policies = {
      AppAutoUpdate                 = false;
      BackgroundAppUpdate           = false;
      
      DisableFirefoxStudies         = true;
      DisableFirefoxAccounts        = true;
      DisableFirefoxScreenshots     = true;
      DisableForgetButton           = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport          = true;
      DisableProfileRefresh         = true;
      DisableSetDesktopBackground   = true;
      DisablePocket                 = true;
      DisableTelemetry              = true;
      DisableFormHistory            = true;
      DisablePasswordReveal         = true;
      
      BlockAboutConfig              = false;
      BlockAboutProfiles            = false;
      BlockAboutSupport             = true;
      
      DisplayMenuBar                = "never";
      DontCheckDefaultBrowser       = true;
      OfferToSaveLogins             = false;

      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url       = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
	  install_url = moz "1password-x-password-manager";
          installation_mode = "force_installed";
	  updates_disabled = true;
	  default_area = "navbar";
        };
	"addon@darkreader.org" = {
	  install_url = moz "darkreader";
	  installation_mode = "force_installed";
	  updates_disabled = true;
	};
	"jid1-MnnxcxisBPnSXQ@jetpack" = {
	  install_url = moz "privacy-badger17";
          installation_mode = "force_installed";
	  updates_disabled = true;
        };
        "3rdparty".Extensions = {
          "uBlock0@raymondhill.net".adminSettings = {
            userSettings = rec {
              uiTheme            = "dark";

              importedLists = [
                "https:#filters.adtidy.org/extension/ublock/filters/3.txt"
                "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              ];

              externalLists = lib.concatStringsSep "\n" importedLists;
            };

            selectedFilterLists = [
              "CZE-0"
              "adguard-generic"
              "adguard-annoyance"
              "adguard-social"
              "adguard-spyware-url"
              "easylist"
              "easyprivacy"
              "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              "plowe-0"
              "ublock-abuse"
              "ublock-badware"
              "ublock-filters"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "urlhaus-1"
            ];
          };
        };
      };
    };
    profiles.default = {
      id = 0;
      isDefault = true;

      search.force = true;
      search.default = "SearXNG";
      search.privateDefault = "SearXNG";
      search.engines = {
        "SearXNG" = {
          urls = [{
            template = "https://search.aino-spring.com/";
            params = [
              { name = "q"; value = "{searchTerms}"; }
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
  home.sessionVariables.MOZ_USE_XINPUT2 = "1";

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
