{ config, pkgs, lib, ... }:

let
	cfg = config.tools;
in
{
	imports = [
		./dev.nix
		./nix-ld.nix
	];

	options.tools = {
		enable = lib.mkEnableOption "Enable tools";
	};
	
	config = lib.mkMerge [
		(lib.mkIf cfg.enable {
			services.openssh.enable = true;

			services.pcscd.enable = true;
			programs.gnupg = {
				agent = {
					enable = true;
					enableSSHSupport = true;
					pinentryPackage = pkgs.pinentry-curses;
				};
			};

			services.udev.extraRules = ''
				SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="0666"
			'';
		})
	];
}
