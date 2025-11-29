{ pkgs, lib, config, ... }:

let
	cfg = config.conn;
in
{
	options.conn = {
		bluetooth.enable = lib.mkEnableOption "Bluetooth support";
		network.enable = lib.mkEnableOption "Networking support";
		avahi.enable = lib.mkEnableOption "Avahi support";
	};

	config = lib.mkMerge [
		(lib.mkIf cfg.bluetooth.enable {
			hardware.bluetooth = {
				enable = true;
				powerOnBoot = true;
				settings = {
					General = {
						Experimental = true;
						FastConnectable = true;
					};
					Policy = {
						AutoEnable = true;
					};
				};
			};

			environment.systemPackages = with pkgs; [
				bluez
			];

			services.blueman.enable = true;
		})

		(lib.mkIf cfg.network.enable {
			networking.networkmanager.enable = true;
		})

		(lib.mkIf cfg.avahi.enable {
			services.avahi = {
				enable = true;
				nssmdns4 = true;
				openFirewall = true;
				publish = {
					enable = true;
					userServices = true;
				};
			};
		})
	];
}
