{ pkgs, inputs, ... }:

{
	imports = [
		../../../shared/modules/nvim.nix
	];

	tools.enable = true;

	environment.packages = [
		(inputs.nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvim config._shared.nixvim)
	];

	environment.etcBackupExtension = ".bak";

	system.stateVersion = "25.05";
}
