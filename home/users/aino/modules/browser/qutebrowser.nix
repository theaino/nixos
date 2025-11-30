{ config, lib, ... }:

let
	cfg = config.browser;
in
{
	config = lib.mkIf (cfg.enable && cfg.variant == "qutebrowser") {
		programs.qutebrowser = {
			enable = true;
			searchEngines = {
				DEFAULT = "https://search.aino-spring.com/search?q={}";
				nw = "https://wiki.nixos.org/w/index.php?search={}";
				np = "https://search.nixos.org/packages?channel=unstable&query={}";
				no = "https://search.nixos.org/options?channel=unstable&query={}";
			};
			settings = {
				url.start_pages = [ "https://search.aino-spring.com" ];

				colors = {
					webpage = {
						bg = "${config.lib.stylix.colors.withHashtag.base00}";
						preferred_color_scheme = "dark";
						darkmode = {
							enabled = true;
						};
					};
				};
			};
		};
	};
}
