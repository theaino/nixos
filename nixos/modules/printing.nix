{ config, pkgs, lib, ... }:

let
	cfg = config.printing;
in
{
	options.printing = {
		enable = lib.mkEnableOption "Enable printing";
	};

	config = lib.mkIf cfg.enable {
		conn.avahi.enable = true;

		services.printing = {
			enable = true;
			browsing = true;
			defaultShared = true;
			openFirewall = true;
			drivers = with pkgs; [ gutenprint cups-filters cups-browsed brlaser cups-brother-hll2350dw ];
		};
	};
}
