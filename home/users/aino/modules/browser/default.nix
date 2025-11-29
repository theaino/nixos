{ config, lib, ... }:

let
	cfg = config.browser;
in
{
	imports = [
		./qutebrowser.nix
		./firefox.nix
	];

	options.browser = {
		enable = lib.mkEnableOption "Enable web browser";
		variant = lib.mkOption {
			type = lib.types.enum [ "firefox" "qutebrowser" ];
			default = "firefox";
			description = "The browser variant to use";
		};
	};
	
	config = lib.mkIf cfg.enable (lib.mkMerge [
		(lib.mkIf (cfg.variant == "firefox") {
			programs.firefox.enable = true;
		})
		(lib.mkIf (cfg.variant == "qutebrowser") {
			programs.qutebrowser.enable = true;
		})
		{
			home.sessionVariables = {
				BROWSER = cfg.variant;
			};
		}
	]);
}
