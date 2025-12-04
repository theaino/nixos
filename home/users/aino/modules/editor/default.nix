{ config, lib, ... }:

let
	cfg = config.editor;
in
{
	imports = [
		../../../../../shared/modules/nvim.nix
	];

	options.editor = {
		enable = lib.mkEnableOption "Enable editor";
		variant = lib.mkOption {
			type = lib.types.enum [ "nvim" ];
			default = "nvim";
			description = "The editor variant to use";
		};
	};

	config = lib.mkIf cfg.enable (lib.mkMerge [
		(lib.mkIf (cfg.variant == "nvim") {
			programs.nixvim = config._shared.nixvim;
		})
	]);
}
