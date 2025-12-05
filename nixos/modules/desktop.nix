{ pkgs, lib, config, ... }:

let
	cfg = config.desktop;
in
{
	options.desktop = {
		enable = lib.mkEnableOption "Desktop environment";
		swapcaps.enable = lib.mkEnableOption "Swap capslock and escape";
		dwm.enable = lib.mkEnableOption "Enable the dwm desktop";
	};

	config = lib.mkMerge [
		(lib.mkIf cfg.enable {
			programs.dconf.enable = true;
			services.dbus.enable = true;
			services.gnome.gnome-keyring.enable = true;

			services.xserver = {
				enable = true;
				xkb = {
					layout = "de";
					variant = "";
				};
				wacom.enable = true;
			};

			services.displayManager.ly.enable = true;

			services.picom.enable = true;
		})

		(lib.mkIf cfg.swapcaps.enable {
			services.keyd = {
				enable = true;
				keyboards = {
					default = {
						ids = [ "*" ];
						settings = {
							main = {
								capslock = "escape";
								escape = "capslock";
							};
							otherlayer = {};
						};
					};
				};
			};
			environment.etc."libinput/local-overrides.quirks".text = ''
				[Serial Keyboards]
				MatchUdevType=keyboard
				MatchName=keyd virtual keyboard
				AttrKeyboardIntegration=internal
			'';
		})

		(lib.mkIf cfg.dwm.enable {
			environment.systemPackages = with pkgs; [
				dwm-flexipatch
				j4-run
				acpi
			];

			services.xserver = {
				enable = true;
				windowManager.dwm = {
					enable = true;
					package = pkgs.dwm-flexipatch;
				};
			};
		})
	];
}
