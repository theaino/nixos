{ config, pkgs, lib, ... }:

let
	cfg = config.browser;
in
{
	config = lib.mkIf (cfg.enable && cfg.variant == "firefox") {
    stylix.targets.firefox = {
			firefoxGnomeTheme.enable = true;
			profileNames = [ "default" ];
    };

		programs.firefox = {
			enable = true;
			policies = {
				AppAutoUpdate                 = false;
				BackgroundAppUpdate           = false;

				AutofillAddressEnabled        = false;
				AutofillCreditCardEnabled     = false;
				
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
				TranslateEnabled              = false;

				FirefoxHome = {
					Search = true;
					TopSites = true;
					SponsoredTopSites = false;
					Highlights = false;
					Pocket = false;
					Stories = false;
					SponsoredPocket = false;
					SponsoredStories = false;
					Snippets = false;
					Locked = false;
				};

				FirefoxSuggest = {
					SponsoredSuggestions = false;
				};
			};
			profiles.default = {
				id = 0;
				isDefault = true;

				settings = {
					"extensions.quarantinedDomains.enabled" = false;
				};

				extensions = {
					force = true;

					packages = with pkgs.nur.repos.rycee.firefox-addons; [
						ublock-origin
						tridactyl
						darkreader
						privacy-badger
						bitwarden
					];

					settings = {
						"tridactyl.vim@cmcaine.co.uk".permissions = [
							"activeTab"
							"bookmarks"
							"browsingData"
							"contextMenus"
							"contextualIdentities"
							"cookies"
							"clipboardWrite"
							"clipboardRead"
							"downloads"
							"find"
							"history"
							"search"
							"sessions"
							"storage"
							"tabHide"
							"tabs"
							"topSites"
							"management"
							"nativeMessaging"
							"webNavigation"
							"webRequest"
							"webRequestBlocking"
							"proxy"
							"<all_urls>"
						];

						"uBlock0@raymondhill.net".settings.selectedFilterLists = [
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
						definedAliases = [ "@p" ];
					};
					"Nix Options" = {
						definedAliases = [ "@o" ];
						urls = [{
							template = "https://search.nixos.org/options";
							params = [
								{ name = "query"; value = "{searchTerms}"; }
							];
						}];
					};
					"NixOS Wiki" = {
						urls = [
							{
								template = "https://wiki.nixos.org/w/index.php";
								params = [
									{ name = "search"; value = "{searchTerms}"; }
								];
							}
						];
						icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
						definedAliases = [ "@w" ];
					};
				};
			};
		};
		home.sessionVariables.MOZ_USE_XINPUT2 = "1";
	};
}
