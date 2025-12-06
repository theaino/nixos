{ config, pkgs, lib, ... }:

let
	cfg = config.browser;
in
{
	imports = [
		./qutebrowser
		./firefox.nix
		./zen.nix
	];

	options.browser = {
		enable = lib.mkEnableOption "Enable web browser";
		variant = lib.mkOption {
			type = lib.types.enum [ "firefox" "qutebrowser" "zen-beta" ];
			default = "firefox";
			description = "The browser variant to use";
		};
	};
	
	config = lib.mkIf cfg.enable (lib.mkMerge [
		{
			home.sessionVariables = {
				BROWSER = cfg.variant;
			};
		}
	]);
}
