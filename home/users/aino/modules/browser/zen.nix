{ config, pkgs, lib, ... }:

let
	cfg = config.browser;
in
{
	config = lib.mkIf (cfg.variant == "zen-beta") {
		stylix.targets.zen-browser.profileNames = [ "default" ];

		programs.zen-browser = {
			enable = true;
			nativeMessagingHosts = with pkgs; [
				firefoxpwa
			];
			policies = {
				AutofillAddressEnabled = false;
				AutofillCreditCardEnabled = false;
				DisableAppUpdate = true;
				DisableFeedbackCommands = true;
				DisableFirefoxStudies = true;
				DisablePocket = true;
				DisableTelemetry = true;
				DontCheckDefaultBrowser = true;
				NoDefaultBookmarks = true;
				OfferToSaveLogins = false;
				TranslateEnabled = false;
			};
			profiles."default" = {
				isDefault = true;
				settings = {
					"extensions.quarantinedDomains.enabled" = false;
					"extensions.autoDisableScopes" = 0;
					"zen.view.compact.enable-at-startup" = true;
        	"zen.view.compact.hide-toolbar" = true;
					"zen.welcome-screen.seen" = true;
				};
				extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
					ublock-origin
					darkreader
					privacy-badger
					bitwarden
				];
				search = {
					force = true;
					default = "SearXNG";
					privateDefault = "SearXNG";
					engines = {
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
		};
	};
}
